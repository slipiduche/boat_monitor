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
  });

  List<Alert> alerts;

  factory ServerAlerts.fromJson(Map<String, dynamic> json) => ServerAlerts(
        alerts: List<Alert>.from(json["ALERTS"].map((x) => Alert.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ALERTS": List<dynamic>.from(alerts.map((x) => x.toJson())),
      };
}

class Alert {
  Alert({
    this.token,
    this.ini,
    this.end,
    this.id,
    this.histId,
    this.journeyId,
    this.boatId,
    this.last,
    this.csv,
  });

  String token;
  DateTime ini;
  DateTime end;
  List<int> id;
  List<int> histId;
  List<int> journeyId;
  List<int> boatId;
  bool last;
  bool csv;

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
        token: json["token"],
        ini: DateTime.parse(json["ini"]),
        end: DateTime.parse(json["end"]),
        id: List<int>.from(json["id"].map((x) => x)),
        histId: List<int>.from(json["hist_id"].map((x) => x)),
        journeyId: List<int>.from(json["journey_id"].map((x) => x)),
        boatId: List<int>.from(json["boat_id"].map((x) => x)),
        last: json["last"],
        csv: json["csv"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "ini": ini.toIso8601String(),
        "end": end.toIso8601String(),
        "id": List<dynamic>.from(id.map((x) => x)),
        "hist_id": List<dynamic>.from(histId.map((x) => x)),
        "journey_id": List<dynamic>.from(journeyId.map((x) => x)),
        "boat_id": List<dynamic>.from(boatId.map((x) => x)),
        "last": last,
        "csv": csv,
      };
}
