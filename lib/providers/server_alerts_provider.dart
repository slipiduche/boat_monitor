import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/pendingApprovals_bloc.dart';
import 'package:boat_monitor/bloc/server_alerts_bloc.dart';

import 'package:boat_monitor/models/pendingApprovals_model.dart';
import 'package:boat_monitor/models/server_alerts_model.dart';
import 'package:boat_monitor/providers/parameters.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:http/io_client.dart';

final _prefs = new UserPreferences();

class AlertsProvider {
  Future<Map<String, dynamic>> getAlerts(BuildContext context) async {
    Map<String, dynamic> decodedResp;
    var _req = jsonEncode({"token": _prefs.token});

    final _req2 = {"body": _req};
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http
          .get(
              Uri.parse(Parameters()
                  .alertsUrl), //modificado en archivo fuente de la libreria para enviar body
              body: _req2)
          .then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        decodedResp = json.decode(response.body);
        if (decodedResp["message"] == 'Token expired') {
          print(decodedResp);
          Navigator.of(context).pushReplacementNamed('loginPage');
          return {'ok': false, 'message': 'Token expired'};
        }
        //String token = decodedResp["token"];
        print(decodedResp);
        ServerAlerts _alerts = ServerAlerts.fromJson(decodedResp);
        ServerAlertsBloc().setAlerts = _alerts;
      });
      return {'ok': true, 'message': decodedResp["message"]};
    } catch (e) {
      print('error:');
      print(e.toString());

      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> approveAlertss(
      BuildContext context, List<int> alertssId) async {
    Map<String, dynamic> decodedResp;
    var _req = jsonEncode({
      "token": _prefs.token,
      "tab": "ALERTSS",
      "id": alertssId, //id of the alerts to modify
      "approval": 1,
    });

    final _req2 = {"body": _req};
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http
          .post(
              Uri.parse(Parameters()
                  .modifyUrl), //modificado en archivo fuente de la libreria para enviar body
              body: _req2)
          .then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        decodedResp = json.decode(response.body);
        if (decodedResp["message"] == 'Token expired') {
          print(decodedResp);
          Navigator.of(context).pushReplacementNamed('loginPage');
          return {'ok': false, 'message': 'Token expired'};
        }
        //String token = decodedResp["token"];
        //print(decodedResp);
      });
      AlertsBloc().setAlert = Alerts(decodedResp["message"], "Updated");
      return {'ok': true, 'message': decodedResp["message"]};
    } catch (e) {
      print('error:');
      print(e.toString());
      AlertsBloc().setAlert = Alerts(decodedResp["message"], "Error");
      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> declineAlertss(
      BuildContext context, List<int> alertssId) async {
    Map<String, dynamic> decodedResp;
    var _req = jsonEncode({
      "token": _prefs.token,
      "tab": "ALERTSS",
      "id": alertssId, //id of the alerts to modify
      "approval": 2,
    });

    final _req2 = {"body": _req};
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http
          .post(
              Uri.parse(Parameters()
                  .modifyUrl), //modificado en archivo fuente de la libreria para enviar body
              body: _req2)
          .then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        decodedResp = json.decode(response.body);
        if (decodedResp["message"] == 'Token expired') {
          print(decodedResp);
          Navigator.of(context).pushReplacementNamed('loginPage');
          return {'ok': false, 'message': 'Token expired'};
        }
      });
      AlertsBloc().setAlert = Alerts(decodedResp["message"], "Updated");
      return {'ok': true, 'message': decodedResp["message"]};
    } catch (e) {
      print('error:');
      print(e.toString());
      AlertsBloc().setAlert = Alerts(decodedResp["message"], "Error");
      return {'ok': false, 'message': e.toString()};
    }
  }
}
