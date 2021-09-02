import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:boat_monitor/bloc/pictures_bloc.dart';
import 'package:boat_monitor/models/files_model.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/providers/parameters.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:http/io_client.dart';

final _prefs = new UserPreferences();

class PicturesProvider {
  Future<Map<String, dynamic>> getPictures(BuildContext context,
      {int journeyId, bool download = false}) async {
    Map<String, dynamic> decodedResp;
    Object bodyRequest = {"token": _prefs.token};
    if (journeyId != null) {
      bodyRequest = {
        "token": _prefs.token,
        "journey_id": [journeyId],
        "fl_type": [".jpg"]
      };
    }
    if (download) {
      bodyRequest = {
        "token": _prefs.token,
        "journey_id": [journeyId],
        "fl_type": [".jpg"]
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
                  .filesUrl), //modificado en archivo fuente de la libreria para enviar body
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
        //print(decodedResp["PICTURES"]);
        if (!download) {
          List<dynamic> _picturesJson = decodedResp["PICTURES"];
          Files _pictures;

          _pictures = filesFromJson(response.body);
          PicturesBloc().setPictures = _pictures;
        }
      });
      return {'ok': true, 'message': decodedResp['message']};
    } catch (e) {
      print('error:');
      print(e.toString());
      return {'ok': false, 'message': e.toString()};
    }
  }
}
