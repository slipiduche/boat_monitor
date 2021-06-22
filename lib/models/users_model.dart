// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    this.users,
    this.message,
    this.status,
    this.code,
  });

  List<User> users;
  String message;
  String status;
  int code;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        users: List<User>.from(json["USERS"].map((x) => User.fromJson(x))),
        message: json["message"],
        status: json["status"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "USERS": List<dynamic>.from(users.map((x) => x.toJson())),
        "message": message,
        "status": status,
        "code": code,
      };
}

class User {
  User({
    this.id,
    this.username,
    this.names,
    this.mail,
    this.usertype,
    this.latt,
    this.ldt,
    this.blocked,
    this.st,
    this.approval,
    this.lva,
    this.dt,
  });

  int id;
  String username;
  String names;
  String mail;
  int usertype;
  int latt;
  DateTime ldt;
  int blocked;
  int st;
  int approval;
  dynamic lva;
  DateTime dt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        names: json["names"],
        mail: json["mail"],
        usertype: json["usertype"],
        latt: json["latt"],
        ldt: json["ldt"] == null ? null : DateTime.parse(json["ldt"]),
        blocked: json["blocked"],
        st: json["st"],
        approval: json["approval"],
        lva: json["lva"],
        dt: DateTime.parse(json["dt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "names": names,
        "mail": mail,
        "usertype": usertype,
        "latt": latt,
        "ldt": ldt == null ? null : ldt.toIso8601String(),
        "blocked": blocked,
        "st": st,
        "approval": approval,
        "lva": lva,
        "dt": dt.toIso8601String(),
      };
}
