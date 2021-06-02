// To parse this JSON data, do
//
//     final historics = historicsFromJson(jsonString);

import 'dart:convert';

List<Historics> historicsFromJson(String str) =>
    List<Historics>.from(json.decode(str).map((x) => Historics.fromJson(x)));

String historicsToJson(List<Historics> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Historics {
  Historics({
    this.id,
    this.boatId,
    this.journeyId,
    this.contStatus,
    this.openTime,
    this.contWeight,
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
  int openTime;
  int contWeight;
  double bat;
  double dsk;
  double temp;
  String bLocation;
  int tiP;
  String flName;
  DateTime dt;
  DateTime reg;

  factory Historics.fromJson(Map<String, dynamic> json) => Historics(
        id: json["id"],
        boatId: json["boat_id"],
        journeyId: json["journey_id"],
        contStatus: json["cont_status"],
        openTime: json["open_time"],
        contWeight: json["cont_weight"],
        bat: json["bat"].toDouble(),
        dsk: json["dsk"].toDouble(),
        temp: json["temp"].toDouble(),
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
        "open_time": openTime,
        "cont_weight": contWeight,
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
