import 'dart:convert';

import 'package:boat_monitor/bloc/error_bloc.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  final _errorBloc = ErrorBloc();

  final _prefs = new UserPreferences();
  Future<Map<String, dynamic>> login(String email, String password) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));
    print(basicAuth);

    http.Response response = await http.get(
        Uri.parse('https://api.somewhere.io'),
        headers: <String, String>{'authorization': basicAuth});
    print(response.statusCode);
    print(response.body);

    Map<String, dynamic> decodedResp = json.decode(response.body);

    print(decodedResp);

    if (decodedResp.containsKey('token')) {
      _prefs.token = decodedResp['token'];
      _prefs.email = decodedResp['user'];
      if (_prefs.name == '') {
        _prefs.name = decodedResp['firstName'];
      }
      _prefs.userId = decodedResp['userId'];

      return {'ok': true, 'token': decodedResp['token']};
    } else {
      _errorBloc.errorStreamSink(decodedResp);
      return {'ok': false, 'mensaje': decodedResp['message']};
    }
  }
}
