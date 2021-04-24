import 'dart:convert';

import 'package:boat_monitor/bloc/error_bloc.dart';
import 'package:boat_monitor/providers/parameters.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  final _errorBloc = ErrorBloc();

  final _prefs = new UserPreferences();
  Future<Map<String, dynamic>> login(String email, String password) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));
    print(basicAuth);

    http.Response response = await http.get(Uri.parse(Parameters().loginUrl),
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
      return {'ok': false, 'mensaje': 'failure'};
    }
  }

  Future<Map<String, dynamic>> signUp(
      String name, String email, String password) async {
    final request = {
      'tab': 'USERS',
      'username': name,
      'password': password,
      'names': 'string',
      'mail': email
    };

    http.Response response =
        await http.post(Uri.parse(Parameters().create), body: request);
    print(response.statusCode);
    print(response.body);

    return _result(response);
  }

  Future<Map<String, dynamic>> recovery(String email) async {
    final request = {'mail': email};

    http.Response response =
        await http.get(Uri.parse(Parameters().recovery), headers: request);
    print(response.statusCode);
    print(response.body);

    return _result(response);
  }

  Future<Map<String, dynamic>> passwordChange(String token, String email,
      String userName, String newPassword, int userType) async {
    final request = {
      'token': token,
      'tab': 'USERS',
      'password': newPassword,
      'mail': email,
      'usertype': userType,
    };

    http.Response response =
        await http.put(Uri.parse(Parameters().modify), body: request);
    print(response.statusCode);
    print(response.body);

    return _result(response);
  }

  Future<Map<String, dynamic>> authorizeUsers(
      String token, String email, List<String> users) async {
    final request = {"token": token, "email": email, "listUsers": users};

    http.Response response =
        await http.put(Uri.parse(Parameters().modify), body: request);
    print(response.statusCode);
    print(response.body);

    return _result(response);
  }

  Map<String, dynamic> _result(http.Response response) {
    Map<String, dynamic> decodedResp = json.decode(response.body);
    if (decodedResp['status'] == 'succes') {
      _errorBloc.errorStreamSink(decodedResp);
      return {'ok': true, 'mensaje': 'succes'};
    } else {
      _errorBloc.errorStreamSink(decodedResp);
      return {'ok': false, 'mensaje': decodedResp['message']};
    }
  }
}
