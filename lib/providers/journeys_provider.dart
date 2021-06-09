import 'dart:convert';
import 'dart:io';

import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/journeys_bloc.dart';

import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/providers/mqtt_provider.dart';
import 'package:boat_monitor/providers/parameters.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:http/io_client.dart';

final _prefs = new UserPreferences();

class JourneyProvider {
  Future<Map<String, dynamic>> getJourneys() async {
    Map<String, dynamic> decodedResp;

    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http.get(
          Uri.parse(Parameters()
              .journeysUrl), //modificado en archivo fuente de la libreria para enviar body
          body: {"token": _prefs.token}).then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        decodedResp = json.decode(response.body);
        //String token = decodedResp["token"];
        print(decodedResp["JOURNEYS"]);
        List<dynamic> _journeysJson = decodedResp["JOURNEYS"];
        List<Journey> _journeys = [];
        _journeysJson.forEach((element) {
          Journey _journey = Journey.fromJson(element);
          _journeys.add(_journey);
        });
        JourneysBloc().setJourneys = _journeys;

        print(_journeys[0].ini);
      });
      return {'ok': true, 'message': 'success'};
    } catch (e) {
      print('error:');
      print(e.toString());
      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getJourneysBy() async {
    Map<String, dynamic> decodedResp;

    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http.get(
          Uri.parse(Parameters()
              .journeysUrl), //modificado en archivo fuente de la libreria para enviar body
          body: {"token": _prefs.token}).then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        decodedResp = json.decode(response.body);
        //String token = decodedResp["token"];
        print(decodedResp["JOURNEYS"]);
        List<dynamic> _journeysJson = decodedResp["JOURNEYS"];
        List<Journey> _journeys = [];
        _journeysJson.forEach((element) {
          Journey _journey = Journey.fromJson(element);
          _journeys.add(_journey);
        });
        JourneysBloc().setJourneys = _journeys;

        print(_journeys[0].ini);
      });
      return {'ok': true, 'message': 'success'};
    } catch (e) {
      print('error:');
      print(e.toString());
      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> changeJourneyName(
      String journeyName, int journeyId) async {
    Map<String, dynamic> decodedResp;
    final _request = <String, dynamic>{
      "token": _prefs.token,
      "journey_name": journeyName,
      "tab": "JOURNEYS",
      "id": journeyId.toString()
    };
    print(_request);
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http
          .post(
              Uri.parse(Parameters()
                  .modifyUrl), //modificado en archivo fuente de la libreria para enviar body
              body: _request)
          .then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        decodedResp = json.decode(response.body);
        //String token = decodedResp["token"];
      });
      return {'ok': true, 'message': 'success'};
    } catch (e) {
      print('error:');
      print(e.toString());

      return {'ok': false, 'message': e.toString()};
    }
  }
}
