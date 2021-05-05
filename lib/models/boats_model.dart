import 'package:flutter/cupertino.dart';

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
  {"boatName": "Boat3", "dateCreated": "04/05/2021 12:40", "manager": "Jhon Jose."}
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
