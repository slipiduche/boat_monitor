import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/models/mqtt_models.dart';
import 'package:boat_monitor/providers/parameters.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:flutter/material.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:get_mac/get_mac.dart';

class MQTTClientWrapper {
  MqttServerClient client;
  final _prefs = new UserPreferences();
  // LocationToJsonConverter locationToJsonConverter = LocationToJsonConverter();
  // JsonToLocationConverter jsonToLocationConverter = JsonToLocationConverter();

  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  final VoidCallback onConnectedCallback;
  final Function(String topic, String dataType) onDeviceDataReceivedCallback;

  MQTTClientWrapper(
      this.onConnectedCallback, this.onDeviceDataReceivedCallback);
  final _mqttStreamController = StreamController<dynamic>.broadcast();
  Function(dynamic) get mqttSink => _mqttStreamController.sink.add;

  Stream<dynamic> get mqttStream => _mqttStreamController.stream;
  void disposeStreams() {
    _mqttStreamController?.close();
  }

  Future prepareMqttClient() async {
    print('preparing');
    await _setupMqttClient();
    await _connectClient();
  }

  bool publishData(String data, String topico) {
    _publishMessage(data, topico);
    return true;
  }

  Future<void> _connectClient() async {
    try {
      print('MQTTClientWrapper::aedes client connecting....');
      connectionState = MqttCurrentConnectionState.CONNECTING;
      print('user:${Parameters().user}');
      print('password:${Parameters().password}');
      await client.connect(Parameters().user, Parameters().password);
    } on Exception catch (e) {
      print('MQTTClientWrapper::client exception - $e');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }

    if (client.connectionStatus.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.CONNECTED;
      print('MQTTClientWrapper::MQTT client connected');
    } else {
      print(
          'MQTTClientWrapper::ERROR aedes client connection failed - disconnecting, status is ${client.connectionStatus}');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }
  }

  Future<String> _setupMqttClient() async {
    String _id = await GetMac.macAddress;
    print(_id);
    print('MQTTClientWrapper::Connecting with id BM-APP_$_id');
    client = MqttServerClient(Parameters().domainMqtt, 'BM-APP_$_id');
    //print('MQTTClientWrapper::Connecting with id BM-APP_/$_id');
    // client = MqttClient.withPort(
    //     Parameters().domainMqtt, 'sA/$_id', Parameters().portMqtt);
    client.port = Parameters().portMqtt;
    client.logging(on: true);

    client.secure = true;
    client.setProtocolV311();
    client.pongCallback = pong;
    final connMess = MqttConnectMessage().withClientIdentifier('BM-APP_$_id');

    client.connectionMessage = connMess;
    client.keepAlivePeriod = 60;
    client.onBadCertificate = _onBadCertificate;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
    return _id;
  }

  bool _onBadCertificate(dynamic) {
    return true;
  }

  /// Pong callback
  void pong() {
    print('EXAMPLE::Ping response client callback invoked');
  }

  void subscribeToTopic(String topicName) {
    print('MQTTClientWrapper::Subscribing to the $topicName topic');
    client.subscribe(topicName, MqttQos.atMostOnce);

    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;
      final String serverDataJsonString =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      //final decodedData = json.decode(resp.body.toString());
      // if()

      final serverDataJson = json.decode(serverDataJsonString);
      print("MQTTClientWrapper::GOT A NEW MESSAGE $serverDataJsonString");
      _preData(serverDataJson, topicName);
    });
  }

  void _preData(serverDataJson, topicName) async {
    if (serverDataJson["status"] == "succses") {
      print(serverDataJson["message"]);
      AlertsBloc().setAlert = Alerts(serverDataJson["message"], "Updated");
    } else {
      print(serverDataJson["message"]);
      AlertsBloc().setAlert = Alerts(serverDataJson["message"], "Error");
    }
    if (serverDataJson["TOKEN"] != null) {
      final decodedData = 'hola';
      if (decodedData != null)
        onDeviceDataReceivedCallback(decodedData, topicName);
      return;
    }
  }

  void _publishMessage(String message, String topico) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    print('MQTTClientWrapper::Publishing message $message to topic $topico');
    client.publishMessage(topico, MqttQos.exactlyOnce, builder.payload);
  }

  void _onSubscribed(String topic) {
    print('MQTTClientWrapper::Subscription confirmed for topic $topic');
    subscriptionState = MqttSubscriptionState.SUBSCRIBED;
    if (topic == 'SERVER/RESPONSE') {
      //ServerDataBloc().login();
    }
  }

  void _onDisconnected() async {
    print(
        'MQTTClientWrapper::OnDisconnected client callback - Client disconnection');

    connectionState = MqttCurrentConnectionState.DISCONNECTED;
    // ServerDataBloc()
    //     .serverConnect('SERVER/AUTHORIZE', 'SERVER/RESPONSE', 'REGISTER/INFO');
    // await Future.delayed(Duration(seconds: 2));
  }

  void _onConnected() async {
    String _id = await GetMac.macAddress;
    connectionState = MqttCurrentConnectionState.CONNECTED;
    print(
        'MQTTClientWrapper::OnConnected client callback - Client connection was sucessful');
    onConnectedCallback();
    subscribeToTopic('APP/$_id');
  }

  void journeyStart(int boatId) {
    final _request = {"token": _prefs.token, "id": boatId.toString()};
    publishData(jsonEncode(_request), 'APP/START');
  }

  void journeyStop(int boatId) {
    final _request = {"token": _prefs.token, "id": boatId.toString()};
    publishData(jsonEncode(_request), 'APP/STOP');
  }
}
