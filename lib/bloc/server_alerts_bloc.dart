import 'package:boat_monitor/models/server_alerts_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ServerAlertsBloc {
  dispose() {
    _alertController?.close();
  }

  static final ServerAlertsBloc _singleton = new ServerAlertsBloc._internal();

  factory ServerAlertsBloc() {
    return _singleton;
  }

  ServerAlertsBloc._internal();

  final _alertController = new BehaviorSubject<ServerAlerts>();
  Stream<ServerAlerts> get alerts => _alertController.stream;
  ServerAlerts get alertsValue => _alertController.value;
  set setAlerts(ServerAlerts event) => _alertController.add(event);
  deleteAlert() {
    _alertController.add(null);
  }
}
