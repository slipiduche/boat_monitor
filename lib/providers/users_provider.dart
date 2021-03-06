import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/pendingAlerts_bloc.dart';
import 'package:boat_monitor/bloc/pendingApprovals_bloc.dart';
import 'package:boat_monitor/bloc/users_bloc.dart';
import 'package:boat_monitor/models/pendingApprovals_model.dart';
import 'package:boat_monitor/models/users_model.dart';
import 'package:boat_monitor/providers/parameters.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:http/io_client.dart';

final _prefs = new UserPreferences();

class UserProvider {
  Future<Map<String, dynamic>> getUsers(BuildContext context) async {
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
        if (decodedResp["message"] == 'Token expired') {
          print(decodedResp);
          Navigator.of(context).pushReplacementNamed('loginPage');
          return {'ok': false, 'message': 'Token expired'};
        }
        //String token = decodedResp["token"];
        //print(decodedResp);

        UsersBloc().setUsers = Users.fromJson(decodedResp);
        PendingApprovals approvals = PendingApprovals();
        UsersBloc().usersValue.users.forEach((element) {
          if (element.approval == 0) {
            approvals.pendingapprovals.add(PendingApproval(
                pendingapprovalId: element.id,
                dt: element.dt,
                userName: element.username,
                names: element.names));
          }
        });
        if (approvals.pendingapprovals.length >= 0) {
          PendingApprovalsBloc().setPendingApprovals = approvals;
        }
      });
      return {'ok': true, 'message': decodedResp["message"]};
    } catch (e) {
      print('error:');
      print(e.toString());

      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getUserById(
      BuildContext context, int userId) async {
    Map<String, dynamic> decodedResp;
    var _req = jsonEncode({
      "token": _prefs.token,
      "tab": "USERS",
      "id": [userId], //id of the user to modify
    });

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
        if (decodedResp["message"] == 'Token expired') {
          print(decodedResp);
          Navigator.of(context).pushReplacementNamed('loginPage');
          return {'ok': false, 'message': 'Token expired'};
        }
        //String token = decodedResp["token"];
        //print(decodedResp);

        PendingAlertsBloc().setLastAlertViewed = decodedResp["USERS"][0]["lva"];
        print(PendingAlertsBloc().lastAlertViewedValue);
      });
      return {'ok': true, 'message': decodedResp["message"]};
    } catch (e) {
      print('error:');
      print(e.toString());

      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> alertViewed(
      BuildContext context, int userId, int lastAlertId) async {
    print("sending last viewed");
    Map<String, dynamic> decodedResp;
    var _req = jsonEncode({
      "token": _prefs.token,
      "tab": "USERS",
      "id": [userId], //id of the user to modify
      "lva": lastAlertId,
    });

    final _req2 = {"body": _req};
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http
          .post(
              Uri.parse(Parameters()
                  .modifyUrl), //modificado en archivo fuente de la libreria para enviar body
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
        //print(decodedResp);
      });
      //AlertsBloc().setAlert = Alerts(decodedResp["message"], "Updated");
      return {'ok': true, 'message': decodedResp["message"]};
    } catch (e) {
      print('error:');
      print(e.toString());
      //AlertsBloc().setAlert = Alerts(decodedResp["message"], "Error");
      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> approveUsers(
      BuildContext context, List<int> usersId) async {
    Map<String, dynamic> decodedResp;
    var _req = jsonEncode({
      "token": _prefs.token,
      "tab": "USERS",
      "id": usersId, //id of the user to modify
      "approval": 1,
      "st": 1
    });

    final _req2 = {"body": _req};
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http
          .post(
              Uri.parse(Parameters()
                  .modifyUrl), //modificado en archivo fuente de la libreria para enviar body
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
        //print(decodedResp);
      });
      AlertsBloc().setAlert = Alerts(decodedResp["message"], "Updated");
      return {'ok': true, 'message': decodedResp["message"]};
    } catch (e) {
      print('error:');
      print(e.toString());
      AlertsBloc().setAlert = Alerts(decodedResp["message"], "Error");
      return {'ok': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> declineUsers(
      BuildContext context, List<int> usersId) async {
    Map<String, dynamic> decodedResp;
    var _req = jsonEncode({
      "token": _prefs.token,
      "tab": "USERS",
      "id": usersId, //id of the user to modify
      "approval": 2,
    });

    final _req2 = {"body": _req};
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      await http
          .post(
              Uri.parse(Parameters()
                  .modifyUrl), //modificado en archivo fuente de la libreria para enviar body
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
        //print(decodedResp);
      });
      AlertsBloc().setAlert = Alerts(decodedResp["message"], "Updated");
      return {'ok': true, 'message': decodedResp["message"]};
    } catch (e) {
      print('error:');
      print(e.toString());
      AlertsBloc().setAlert = Alerts(decodedResp["message"], "Error");
      return {'ok': false, 'message': e.toString()};
    }
  }
}
