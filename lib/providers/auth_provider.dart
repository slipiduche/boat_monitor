import 'dart:convert';
import 'dart:io';

import 'package:boat_monitor/bloc/error_bloc.dart';
import 'package:boat_monitor/providers/parameters.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:http/io_client.dart';

class AuthProvider {
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
        _prefs.token = decodedResp["token"];
        print(_prefs.token);
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
    final request = {
      'tab': 'USERS',
      'username': name,
      'password': password,
      'names': 'string',
      'mail': email
    };
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final response =
          await http.post(Uri.parse(Parameters().createUrl), body: request);
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

    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final response =
          await http.get(Uri.parse(Parameters().recoveryUrl), headers: request);
      print(response.statusCode);
      print(response.body);

      return _result(response);
    } catch (e) {
      print('error:');
      print(e.toString());
      return {'ok': false, 'message': e.toString()};
    }
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

    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final response =
          await http.put(Uri.parse(Parameters().modifyUrl), body: request);
      print(response.statusCode);
      print(response.body);

      return _result(response);
    } catch (e) {
      print('error:');
      print(e.toString());
      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> authorizeUsers(
      String token, String email, List<String> users) async {
    final request = {"token": token, "email": email, "listUsers": users};

    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final response =
          await http.put(Uri.parse(Parameters().modifyUrl), body: request);
      print(response.statusCode);
      print(response.body);

      return _result(response);
    } catch (e) {
      print('error:');
      print(e.toString());
      return {'ok': false, 'message': e.toString()};
    }
  }

  Map<String, dynamic> _result(http.Response response) {
    Map<String, dynamic> decodedResp = json.decode(response.body);
    if (decodedResp['status'] == 'succes') {
      _errorBloc.errorStreamSink(decodedResp);
      return {'ok': true, 'message': 'succes'};
    } else {
      _errorBloc.errorStreamSink(decodedResp);
      return {'ok': false, 'message': decodedResp['message']};
    }
  }
}
