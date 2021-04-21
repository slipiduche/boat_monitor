import 'dart:convert';

import 'package:boat_monitor/bloc/error_bloc.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  final _errorBloc = ErrorBloc();

  final _prefs = new UserPreferences();
  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      "email": email,
      "password": password,
    };
    print(json.encode(authData));
    final resp = await http.post(
        Uri.parse('http://orbittas.ddns.net:8081/api/login'),
        headers: authData);

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if (decodedResp.containsKey('token')) {
      _prefs.token = decodedResp['token'];
      _prefs.email = decodedResp['user'];
      if (_prefs.nombre == '') {
        _prefs.nombre = decodedResp['firstName'];
      }
      _prefs.userId = decodedResp['userId'];

      return {'ok': true, 'token': decodedResp['token']};
    } else {
      _errorBloc.errorStreamSink(decodedResp);
      return {'ok': false, 'mensaje': decodedResp['message']};
    }
  }
}
