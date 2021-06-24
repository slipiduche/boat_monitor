// To parse this JSON data, do
//
//     final serverAlerts = serverAlertsFromJson(jsonString);

import 'dart:convert';

ServerAlerts serverAlertsFromJson(String str) =>
    ServerAlerts.fromJson(json.decode(str));

String serverAlertsToJson(ServerAlerts data) => json.encode(data.toJson());

class ServerAlerts {
  ServerAlerts({
    this.alerts,
    this.message,
    this.status,
    this.code,
  });

  List<Alert> alerts;
  String message;
  String status;
  int code;

  factory ServerAlerts.fromJson(Map<String, dynamic> json) => ServerAlerts(
        alerts: List<Alert>.from(json["ALERTS"].map((x) => Alert.fromJson(x))),
        message: json["message"],
        status: json["status"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "ALERTS": List<dynamic>.from(alerts.map((x) => x.toJson())),
        "message": message,
        "status": status,
        "code": code,
      };
}

class Alert {
  Alert({
    this.id,
    this.histId,
    this.boatId,
    this.journeyId,
    this.ta,
    this.wa,
    this.ua,
    this.sus,
    this.dt,
    this.descr,
  });

  int id;
  int histId;
  int boatId;
  int journeyId;
  int ta;
  int wa;
  int ua;
  int sus;
  DateTime dt;
  String descr;

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
        id: json["id"],
        histId: json["hist_id"],
        boatId: json["boat_id"],
        journeyId: json["journey_id"],
        ta: json["ta"],
        wa: json["wa"],
        ua: json["ua"],
        sus: json["sus"],
        dt: DateTime.parse(json["dt"]),
        descr: json["descr"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hist_id": histId,
        "boat_id": boatId,
        "journey_id": journeyId,
        "ta": ta,
        "wa": wa,
        "ua": ua,
        "sus": sus,
        "dt": dt.toIso8601String(),
        "descr": descr,
      };
}
