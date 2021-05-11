import 'package:flutter/cupertino.dart';
import 'dart:convert';

final boatsTest = [
  {
    "boatName": "Boat1",
    "dateCreated": "04/05/2021 12:38",
    "manager": "Jhon Alejandro."
  },
  {
    "boatName": "Boat2",
    "dateCreated": "04/05/2021 12:39",
    "manager": "Jhon Aristocratico Manuel pedro y pablo."
  },
  {
    "boatName": "Boat3",
    "dateCreated": "04/05/2021 12:40",
    "manager": "Jhon Jose."
  }
];

class Boat {
  String boatName;
  String manager;
  String dateCreated;
  Boat({this.boatName, this.dateCreated, this.manager});
  factory Boat.fromJson(Map<String, dynamic> json) => Boat(
      boatName: json["boatName"],
      dateCreated: json["dateCreated"],
      manager: json["manager"]);
}

class Boats {
  List<Boat> boats = [];
  Boats();
  Boats.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      Boat boat = Boat.fromJson(item);

      boats.add(boat);
    }
  }
  List<Boat> get getBoats {
    Boats.fromJsonList(boatsTest);

    return boats;
  }
}

// To parse this JSON data, do
//
//     final boatData = boatDataFromJson(jsonString);

BoatData boatDataFromJson(String str) => BoatData.fromJson(json.decode(str));

String boatDataToJson(BoatData data) => json.encode(data.toJson());

class BoatData {
  BoatData({
    this.id,
    this.mac,
    this.boatName,
    this.maxSt,
    this.st,
    this.resp,
    this.respName,
    this.obs,
    this.dt,
  });

  int id;
  String mac;
  String boatName;
  double maxSt;
  int st;
  int resp;
  String respName;
  String obs;
  DateTime dt;

  factory BoatData.fromJson(Map<String, dynamic> json) => BoatData(
        id: json["id"],
        mac: json["mac"],
        boatName: json["boat_name"],
        maxSt: json["max_st"].toDouble(),
        st: json["st"],
        resp: json["resp"],
        respName: json["resp_name"],
        obs: json["obs"],
        dt: DateTime.parse(json["dt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mac": mac,
        "boat_name": boatName,
        "max_st": maxSt,
        "st": st,
        "resp": resp,
        "resp_name": respName,
        "obs": obs,
        "dt": dt,
      };
}
