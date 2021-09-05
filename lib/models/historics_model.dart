// To parse this JSON data, do
//
//     final historics = historicsFromJson(jsonString);

import 'dart:convert';

Historics historicsFromJson(String str) => Historics.fromJson(json.decode(str));

String historicsToJson(Historics data) => json.encode(data.toJson());

class Historics {
  Historics({
    this.historics,
    this.message,
    this.status,
    this.code,
  });

  List<Historic> historics;
  String message;
  String status;
  int code;

  factory Historics.fromJson(Map<String, dynamic> json) => Historics(
        historics: List<Historic>.from(
            json["HISTORICS"].map((x) => Historic.fromJson(x))),
        message: json["message"],
        status: json["status"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "HISTORICS": List<dynamic>.from(historics.map((x) => x.toJson())),
        "message": message,
        "status": status,
        "code": code,
      };
}

class Historic {
  Historic({
    this.id,
    this.boatId,
    this.journeyId,
    this.contStatus,
    this.contWeight,
    this.openTime,
    this.bat,
    this.dsk,
    this.temp,
    this.bLocation,
    this.tiP,
    this.flName,
    this.dt,
    this.reg,
  });

  int id;
  int boatId;
  int journeyId;
  int contStatus;
  double contWeight;
  double openTime;
  double bat;
  double dsk;
  double temp;
  String bLocation;
  int tiP;
  String flName;
  DateTime dt;
  DateTime reg;

  factory Historic.fromJson(Map<String, dynamic> json) => Historic(
        id: json["id"],
        boatId: json["boat_id"],
        journeyId: json["journey_id"],
        contStatus: json["cont_status"],
        contWeight:
            json["cont_weight"] == null ? 0 : json["cont_weight"].toDouble(),
        openTime: json["open_time"] == null ? 0 : json["open_time"].toDouble(),
        bat: json["bat"] == null ? 0 : json["bat"].toDouble(),
        dsk: json["dsk"] == null ? 0 : json["dsk"].toDouble(),
        temp: json["temp"] == null ? 0 : json["temp"].toDouble(),
        bLocation: json["b_location"],
        tiP: json["TiP"],
        flName: json["fl_name"],
        dt: DateTime.parse(json["dt"]),
        reg: DateTime.parse(json["reg"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "boat_id": boatId,
        "journey_id": journeyId,
        "cont_status": contStatus,
        "cont_weight": contWeight,
        "open_time": openTime,
        "bat": bat,
        "dsk": dsk,
        "temp": temp,
        "b_location": bLocation,
        "TiP": tiP,
        "fl_name": flName,
        "dt": dt.toIso8601String(),
        "reg": reg.toIso8601String(),
      };
}

final historicsTest = [
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
  },
  {
    "HISTORICS": [
      {
        "id": 1,
        "boat_id": 1,
        "journey_id": 1,
        "cont_status": 1,
        "open_time": 1,
        "cont_weight": 20.0,
        "bat": 12.6,
        "dsk": 250.2,
        "temp": 37.6,
        "b_location": "string",
        "TiP": 1.0,
        "fl_name": "holahola",
        "dt": "2021-04-27T19:35:00.000Z",
        "reg": "2021-04-27T19:35:00.000Z"
      }
    ]
  }
];
