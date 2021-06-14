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
  Future<Map<String, dynamic>> getHistorics(
      {List<int> journeyId, bool download = false, bool last = false}) async {
    Map<String, dynamic> decodedResp;
    Object bodyRequest = {"token": _prefs.token};
    if (journeyId != null) {
      bodyRequest = {
        "token": _prefs.token,
        "journey_id": [journeyId],
        "last": last
      };
    }
    if (download) {
      bodyRequest = {
        "token": _prefs.token,
        "journey_id": [journeyId],
        "csv": true,
        "last": last
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
                  .historicsUrl), //modificado en archivo fuente de la libreria para enviar body
              body: _req2)
          .then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        decodedResp = json.decode(response.body);
        //String token = decodedResp["token"];
        //print(decodedResp["HISTORICS"]);
        if (!download) {
          List<dynamic> _historicsJson = decodedResp["HISTORICS"];
          Historics _historics;

          _historics = historicsFromJson(response.body);
          HistoricsBloc().setHistorics = _historics;
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
