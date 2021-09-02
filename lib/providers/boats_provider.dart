import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/boats_bloc.dart';
import 'package:boat_monitor/models/boats_model.dart';
import 'package:boat_monitor/models/users_model.dart';
import 'package:boat_monitor/providers/parameters.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:http/io_client.dart';

final _prefs = new UserPreferences();

class BoatProvider {
  Future<Map<String, dynamic>> getBoats(BuildContext context) async {
    Map<String, dynamic> decodedResp;
    final _resp = jsonEncode({"token": _prefs.token});
    final _resp2 = {"body": _resp};

    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http
          .get(
              Uri.parse(Parameters()
                  .boatsUrl), //modificado en archivo fuente de la libreria para enviar body
              body: _resp2)
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
        print(decodedResp["BOATS"]);
        List<dynamic> _boatsJson = decodedResp["BOATS"];
        List<BoatData> _boats = [];
        _boatsJson.forEach((element) {
          BoatData _boat = BoatData.fromJson(element);
          _boats.add(_boat);
        });
        BoatsBloc().setBoats = _boats;

        print(_boats[0].dt);
      });
      return {'ok': true, 'message': 'success'};
    } catch (e) {
      print('error:');
      print(e.toString());

      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> changeBoatName(
      String boatName, int boatId, BuildContext context) async {
    Map<String, dynamic> decodedResp;
    final _request = <String, dynamic>{
      "token": _prefs.token,
      "boat_name": boatName,
      "tab": "BOATS",
      "id": boatId.toString()
    };
    final _req2 = {"body": jsonEncode(_request)};
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
      });
      AlertsBloc().setAlert = Alerts(decodedResp["message"], "Updated");
      return {'ok': true, 'message': 'success'};
    } catch (e) {
      print('error:');
      print(e.toString());

      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> changeBoatResponsible(
      User responsible, int boatId) async {
    Map<String, dynamic> decodedResp;
    final _request = <String, dynamic>{
      "token": _prefs.token,
      "resp": responsible.id,
      "resp_name": responsible.names,
      "tab": "BOATS",
      "id": boatId.toString()
    };
    final _req2 = {"body": jsonEncode(_request)};
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
              body: _req2)
          .then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        decodedResp = json.decode(response.body);
        //String token = decodedResp["token"];
      });
      AlertsBloc().setAlert = Alerts(decodedResp["message"], "Updated");
      return {'ok': true, 'message': 'success'};
    } catch (e) {
      print('error:');
      print(e.toString());

      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> deleteBoats(List<int> boatIds) async {
    Map<String, dynamic> decodedResp;
    final _request = <String, dynamic>{
      "token": _prefs.token,
      "tab": "BOATS",
      "id": boatIds,
      "st": false
    };
    final _req2 = {"body": jsonEncode(_request)};
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
              body: _req2)
          .then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        decodedResp = json.decode(response.body);
        //String token = decodedResp["token"];
      });
      //AlertsBloc().setAlert = Alerts(decodedResp["message"], "Updated");
      return {'ok': true, 'message': 'success'};
    } catch (e) {
      print('error:');
      print(e.toString());

      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> restoreBoats(List<int> boatIds) async {
    Map<String, dynamic> decodedResp;
    final _request = <String, dynamic>{
      "token": _prefs.token,
      "tab": "BOATS",
      "id": boatIds,
      "st": true
    };
    final _req2 = {"body": jsonEncode(_request)};
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
              body: _req2)
          .then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        decodedResp = json.decode(response.body);
        //String token = decodedResp["token"];
      });
      //AlertsBloc().setAlert = Alerts(decodedResp["message"], "Updated");
      return {'ok': true, 'message': 'success'};
    } catch (e) {
      print('error:');
      print(e.toString());

      return {'ok': false, 'message': e.toString()};
    }
  }
}
