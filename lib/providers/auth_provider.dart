import 'dart:convert';

import 'dart:io';

import 'package:boat_monitor/bloc/error_bloc.dart';
import 'package:boat_monitor/providers/parameters.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:http/io_client.dart';

class AuthProvider {
  bool _digit(String char) {
    try {
      int digit = int.parse(char);
      print(digit);
      return true;
    } catch (e) {
      return false;
    }
  }

  void naNFinder(String token) {
    int position = token.length - 1;
    int result;
    for (var i = position; i >= 0; i--) {
      if (!_digit(token[i])) {
        result = i;

        break;
      }
    }
    print(result);
    print(token.length);
    if (result != null) {
      _prefs.token = token;
      print(_prefs.token);
      print(token.substring(result - 1, position));
      _prefs.userId = int.parse(token.substring(result - 1, position));
      print(_prefs.userId);
    }
  }

  final _errorBloc = ErrorBloc();

  final _prefs = new UserPreferences();
  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> decodedResp;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));
    print(basicAuth);

    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http.get(Uri.parse(Parameters().loginUrl),
          headers: <String, String>{
            'authorization': basicAuth
          }).then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        decodedResp = json.decode(response.body);
        //String token = decodedResp["token"];
        print(decodedResp);
      });

      if (decodedResp["token"] != null) {
        String _token, _filteredToken;

        int userId;
        _token = decodedResp["token"];
        print(_token.substring(_token.length - 2, _token.length - 1));
        naNFinder(_token);

        _prefs.email = email;
        _prefs.userType = decodedResp["usertype"];
        // print(_prefs.token);
        //_prefs.email = decodedResp['user'];

        return {'ok': true, 'token': decodedResp['token']};
      } else {
        _errorBloc.errorStreamSink(decodedResp);
        return {'ok': false, 'message': decodedResp['message']};
      }
    } catch (e) {
      print('error:');
      print(e.toString());
      _errorBloc.errorStreamSink(decodedResp);
      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> signUp(
      String name, String email, String password) async {
    String basicAuth = 'Basic ' +
        base64Encode(
            utf8.encode('SUD@orbittas.com:p<RhA7#X_LWBB(O_0&<a,D/,f#2")7B+'));

    final request = {
      'tab': 'USERS',
      'username': email,
      'pswrd': password,
      'names': name,
      'mail': email
    };
    var _req = jsonEncode(request);
    final _req2 = {"body": _req};
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final response = await http.post(Uri.parse(Parameters().signUpUrl),
          body: _req2, headers: <String, String>{'authorization': basicAuth});
      print(response.statusCode);
      print(response.body);

      return _result(response);
    } catch (e) {
      print('error:');
      print(e.toString());
      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> recovery(String email) async {
    final request = {'mail': email};
    var _req = jsonEncode(request);
    final _req2 = {"body": _req};
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final response =
          await http.post(Uri.parse(Parameters().modifyUrl), body: _req2);

      return _result(response);
    } catch (e) {
      print('error:');
      print(e.toString());
      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> passwordChange(String newPassword) async {
    final request = {
      'token': _prefs.token,
      'tab': 'USERS',
      'pswrd': newPassword,
      'mail': _prefs.email,
      //'usertype': _prefs.userType,
    };
    print(request);
    var _req = jsonEncode(request);
    final _req2 = {"body": _req};

    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      print('antes');
      final response =
          await http.post(Uri.parse(Parameters().modifyUrl), body: _req2);
      print('despues');
      print(response.statusCode);
      print(response.body);

      return _result(response);
    } catch (e) {
      print('error:');
      print(e);
      print(e.toString());
      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> authorizeUsers(
      String token, String email, List<String> users) async {
    final request = {"token": token, "email": email, "listUsers": users};
    var _req = jsonEncode(request);
    final _req2 = {"body": _req};
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final response =
          await http.post(Uri.parse(Parameters().modifyUrl), body: _req2);
      print(response.statusCode);
      print(response.body);

      return _result(response);
    } catch (e) {
      print('error:');
      print(e);
      print(e.toString());
      return {'ok': false, 'message': e.toString()};
    }
  }

  Map<String, dynamic> _result(http.Response response) {
    Map<String, dynamic> decodedResp = json.decode(response.body);
    if (decodedResp['status'] == 'success') {
      _errorBloc.errorStreamSink(decodedResp);
      return {'ok': true, 'message': 'success'};
    } else {
      _errorBloc.errorStreamSink(decodedResp);
      return {'ok': false, 'message': decodedResp['message']};
    }
  }
}
