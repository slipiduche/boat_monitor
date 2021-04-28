import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class Alerts {
  String message;
  String type;
  Alerts(this.message, this.type);
}

class AlertsBloc {
  dispose() {
    _alertController?.close();
  }

  static final AlertsBloc _singleton = new AlertsBloc._internal();

  factory AlertsBloc() {
    return _singleton;
  }

  AlertsBloc._internal();
  final _alertClosedController = new BehaviorSubject<bool>();
  Stream<bool> get alertClosed => _alertClosedController.stream;
  bool get alertClosedValue => _alertClosedController.value;
  set setAlertClosed(bool event) => _alertClosedController.add(event);
  final _alertController = new BehaviorSubject<Alerts>();
  Stream<Alerts> get alert => _alertController.stream;
  Alerts get alertValue => _alertController.value;
  set setAlert(Alerts event) => _alertController.add(event);
  deleteAlert() {
    _alertController.add(null);
  }
}
