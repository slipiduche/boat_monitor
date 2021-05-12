import 'dart:convert';
import 'dart:io';

import 'package:boat_monitor/bloc/boats_bloc.dart';
import 'package:boat_monitor/models/boats_model.dart';
import 'package:boat_monitor/providers/parameters.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:http/io_client.dart';

final _prefs = new UserPreferences();

class BoatProvider {
  Future<Map<String, dynamic>> getBoats() async {
    Map<String, dynamic> decodedResp;

    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http.get(
          Uri.parse(Parameters()
              .boatsUrl), //modificado en archivo fuente de la libreria para enviar body
          body: {"token": _prefs.token}).then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        decodedResp = json.decode(response.body);
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
      return {'ok': true, 'message': 'succes'};
    } catch (e) {
      print('error:');
      print(e.toString());

      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> changeBoatName(
      String boatName, int boatId) async {
    Map<String, dynamic> decodedResp;
    final _request=<String, dynamic> {
            "token": _prefs.token,
            "boat_name": boatName,
            "tab":"BOATS",
            "id": boatId.toString()
          };
          print(_request);
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http.post(
          Uri.parse(Parameters()
              .modifyUrl), //modificado en archivo fuente de la libreria para enviar body
          body:_request).then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        decodedResp = json.decode(response.body);
        //String token = decodedResp["token"];
      });
      return {'ok': true, 'message': 'succes'};
    } catch (e) {
      print('error:');
      print(e.toString());

      return {'ok': false, 'message': e.toString()};
    }
  }
}
