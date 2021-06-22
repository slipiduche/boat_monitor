import 'dart:convert';
import 'dart:io';

import 'package:boat_monitor/bloc/users_bloc.dart';
import 'package:boat_monitor/models/users_model.dart';
import 'package:boat_monitor/providers/parameters.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:http/io_client.dart';

final _prefs = new UserPreferences();

class UserProvider {
  Future<Map<String, dynamic>> getUsers() async {
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
                  .usersUrl), //modificado en archivo fuente de la libreria para enviar body
              body: _req2)
          .then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        decodedResp = json.decode(response.body);
        //String token = decodedResp["token"];
        //print(decodedResp);

        UsersBloc().setUsers = Users.fromJson(decodedResp);
      });
      return {'ok': true, 'message': decodedResp["message"]};
    } catch (e) {
      print('error:');
      print(e.toString());

      return {'ok': false, 'message': e.toString()};
    }
  }
}
