import 'dart:convert';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/journeys_bloc.dart';

import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/providers/mqtt_provider.dart';
import 'package:boat_monitor/providers/parameters.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:http/io_client.dart';

final _prefs = new UserPreferences();

class JourneyProvider {
  Future<Map<String, dynamic>> getJourneys(BuildContext context,
      {List<int> journeyIds}) async {
    Map<String, dynamic> decodedResp;
    var _req = jsonEncode({"token": _prefs.token});
    if (journeyIds != null) {
      _req = jsonEncode({"token": _prefs.token, "id": journeyIds});
    }

    final _req2 = {"body": _req};
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http
          .get(
              Uri.parse(Parameters()
                  .journeysUrl), //modificado en archivo fuente de la libreria para enviar body
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

  Future<Map<String, dynamic>> getJourneysBy(
      BuildContext context, List<Journey> journeys) async {
    Map<String, dynamic> decodedResp;
    List<int> idsRequest = [];
    Map<String, dynamic> _request;
    if (journeys.length > 0) {
      journeys.forEach((element) {
        idsRequest.add(element.id);
      });
      _request = {"token": _prefs.token, "id": idsRequest, "csv": true};
    } else {
      _request = {"token": _prefs.token, "csv": true};
    }
    print(jsonEncode(_request));
    final req = jsonEncode(_request);
    print(req);
    final req2 = {"body": req};
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http
          .get(
              Uri.parse(Parameters()
                  .journeysUrl), //modificado en archivo fuente de la libreria para enviar body
              body: req2)
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
      return {'ok': true, 'message': decodedResp["message"]};
    } catch (e) {
      print('error:');
      print(e.toString());
      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getFilesZip(BuildContext context,
      {int journeyId, bool download = false}) async {
    Map<String, dynamic> decodedResp;
    Object bodyRequest = {"token": _prefs.token};
    if (journeyId != null) {
      bodyRequest = {
        "token": _prefs.token,
        "journey_id": [journeyId]
      };
    }

    final _req = jsonEncode(bodyRequest);
    final _req2 = {"body": _req};
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http
          .get(
              Uri.parse(Parameters()
                  .filesZipUrl), //modificado en archivo fuente de la libreria para enviar body
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
      return {'ok': true, 'message': decodedResp['message']};
    } catch (e) {
      print('error:');
      print(e.toString());
      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> changeJourneyName(
      BuildContext context, String journeyName, int journeyId) async {
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
        if (decodedResp["message"] == 'Token expired') {
          print(decodedResp);
          Navigator.of(context).pushReplacementNamed('loginPage');
          return {'ok': false, 'message': 'Token expired'};
        }

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
