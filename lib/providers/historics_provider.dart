import 'dart:convert';
import 'dart:io';

import 'package:boat_monitor/bloc/historics_bloc.dart';
import 'package:boat_monitor/models/historics_model.dart';

import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/providers/parameters.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:http/io_client.dart';

final _prefs = new UserPreferences();

class HistoricsProvider {
  Future<Map<String, dynamic>> getHistorics({int journeyId}) async {
    Map<String, dynamic> decodedResp;
    Object bodyRequest = {"token": _prefs.token};
    if (journeyId != null) {
      bodyRequest = {
        "token": _prefs.token,
        "journey_id": [journeyId]
      };
    }
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http.get(
          Uri.parse(Parameters()
              .historicsUrl), //modificado en archivo fuente de la libreria para enviar body
          body: {"token": _prefs.token}).then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        decodedResp = json.decode(response.body);
        //String token = decodedResp["token"];
        //print(decodedResp["HISTORICS"]);
        List<dynamic> _historicsJson = decodedResp["HISTORICS"];
        Historics _historics;
        
        _historics = historicsFromJson(response.body);
        HistoricsBloc().setHistorics = _historics;
      });
      return {'ok': true, 'message': 'success'};
    } catch (e) {
      print('error:');
      print(e.toString());
      return {'ok': false, 'message': e.toString()};
    }
  }
}
