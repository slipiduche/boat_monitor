import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/parameters_bloc.dart';
import 'package:boat_monitor/bloc/pendingAlerts_bloc.dart';
import 'package:boat_monitor/bloc/pendingApprovals_bloc.dart';
import 'package:boat_monitor/models/parameters_model.dart';

import 'package:boat_monitor/models/pendingApprovals_model.dart';

import 'package:boat_monitor/providers/parameters.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:http/io_client.dart';

final _prefs = new UserPreferences();

class ParametersProvider {
  Future<Map<String, dynamic>> getParameters(BuildContext context) async {
    Map<String, dynamic> decodedResp;
    var _req = jsonEncode(
        {"token": _prefs.token, "user_id": _prefs.userId, "last": true});

    final _req2 = {"body": _req};
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http
          .get(
              Uri.parse(Parameters()
                  .parametersUrl), //modificado en archivo fuente de la libreria para enviar body
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

        ParametersBloc().setParameters = UserParameters.fromJson(decodedResp);
        if (ParametersBloc().parametersValue.params.length < 1) {
          setDefaultParameters(context);
        }
      });
      return {'ok': true, 'message': decodedResp["message"]};
    } catch (e) {
      print('error:');
      print(e.toString());

      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getParameterById(
      BuildContext context, int parameterId) async {
    Map<String, dynamic> decodedResp;
    var _req = jsonEncode({
      "token": _prefs.token,
      "tab": "PARAMS",
      "id": [parameterId], //id of the parameter to modify
    });

    final _req2 = {"body": _req};
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http
          .get(
              Uri.parse(Parameters()
                  .parametersUrl), //modificado en archivo fuente de la libreria para enviar body
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
      return {'ok': true, 'message': decodedResp["message"]};
    } catch (e) {
      print('error:');
      print(e.toString());

      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> setParameters(BuildContext context, parametersId,
      {double weight, double temperature, double timeout}) async {
    Map<String, dynamic> decodedResp;
    var _req;
    if (temperature != null) {
      _req = jsonEncode({
        "token": _prefs.token,
        "tab": "PARAMS",
        "dtemp": temperature,
        "time_out": timeout,
        "dweight": weight
      });
    }
    if (timeout != null) {
      _req = jsonEncode({
        "token": _prefs.token,
        "tab": "PARAMS",
        "time_out": timeout,
        "dweight": weight,
        "dtemp": temperature
      });
    }
    if (weight != null) {
      _req = jsonEncode({
        "token": _prefs.token,
        "tab": "PARAMS",
        "dweight": weight,
        "dtemp": temperature,
        "time_out": timeout
      });
    }

    final _req2 = {"body": _req};
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http
          .post(
              Uri.parse(Parameters()
                  .createUrl), //modificado en archivo fuente de la libreria para enviar body
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

  Future<Map<String, dynamic>> setDefaultParameters(
      BuildContext context) async {
    Map<String, dynamic> decodedResp;
    var _req = jsonEncode({
      "token": _prefs.token,
      "tab": "PARAMS",
      "dweight": 35.0,
      "dtemp": 5.0,
      "time_out": 7.0
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
                  .createUrl), //modificado en archivo fuente de la libreria para enviar body
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

      return {'ok': true, 'message': decodedResp["message"]};
    } catch (e) {
      print('error:');
      print(e.toString());

      return {'ok': false, 'message': e.toString()};
    }
  }
}
