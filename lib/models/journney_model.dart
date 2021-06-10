import 'dart:convert';

import 'package:boat_monitor/models/historics_model.dart';

final journeysTest = [
  {
    "boatId": 1,
    "dateArrived": "04/05/2021 12:38",
    "dateDeparture": "04/05/2021 12:38",
    "status": "arrived"
  },
  {
    "boatId": 2,
    "dateArrived": "04/05/2021 12:38",
    "dateDeparture": "04/05/2021 12:38",
    "status": "salling"
  },
  {
    "boatId": 3,
    "dateArrived": "04/05/2021 12:38",
    "dateDeparture": "04/05/2021 12:38",
    "status": "arrived"
  }
];

Journeys journeysFromJson(String str) => Journeys.fromJson(json.decode(str));

String journeysToJson(Journeys data) => json.encode(data.toJson());

class Journeys {
  Journeys({
    this.journeys,
    this.status,
    this.code,
  });

  List<Journey> journeys;
  String status;
  int code;

  factory Journeys.fromJson(Map<String, dynamic> json) => Journeys(
        journeys: List<Journey>.from(
            json["JOURNEYS"].map((x) => Journey.fromJson(x))),
        status: json["status"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "JOURNEYS": List<dynamic>.from(journeys.map((x) => x.toJson())),
        "status": status,
        "code": code,
      };
}

class Journey {
  Journey({
    this.id,
    this.ini,
    this.ed,
    this.startUser,
    this.endUser,
    this.boatId,
    this.iWeight,
    this.fWeight,
    this.sImg,
    this.totalImg,
    this.synced,
    this.alert,
    this.eta,
    this.obs,
    this.boatName,
    this.startUserNames,
    this.endUserNames,
  });

  int id;
  DateTime ini;
  DateTime ed;
  int startUser;
  int endUser;
  int boatId;
  double iWeight;
  double fWeight;
  int sImg;
  int totalImg;
  int synced;
  int alert;
  dynamic eta;
  String obs;
  String boatName;
  String startUserNames;
  String endUserNames;

  factory Journey.fromJson(Map<String, dynamic> json) => Journey(
        id: json["id"],
        ini: DateTime.parse(json["ini"]),
        ed: DateTime.parse(json["ed"]),
        startUser: json["start_user"],
        endUser: json["end_user"],
        boatId: json["boat_id"],
        iWeight: json["i_weight"].toDouble(),
        fWeight: json["f_weight"].toDouble(),
        sImg: json["s_img"],
        totalImg: json["total_img"],
        synced: json["synced"],
        alert: json["alert"],
        eta: json["eta"],
        obs: json["obs"],
        startUserNames: json["start_user_names"],
        endUserNames: json["end_user_names"],
        boatName: json["boat_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ini": ini.toIso8601String(),
        "ed": ed.toIso8601String(),
        "start_user": startUser,
        "end_user": endUser,
        "boat_id": boatId,
        "i_weight": iWeight,
        "f_weight": fWeight,
        "s_img": sImg,
        "total_img": totalImg,
        "synced": synced,
        "alert": alert,
        "eta": eta,
        "obs": obs,
      };
}

class JourneyCardArgument {
  Journey journey;
  Historics historics;

  JourneyCardArgument({this.historics, this.journey});
}
