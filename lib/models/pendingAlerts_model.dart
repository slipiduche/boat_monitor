final pendingAlertsTest = [
  {
    "pendingalerid": 1,
    "travelId": 2,
    "message":
        "boat 1 decrase weight : on travel 01 18:00 Weight decreased from 700 KG to 600 KG",
    "boatId": 4
  },
  {
    "pendingalerid": 3,
    "travelId": 5,
    "message":
        "boat 1 increase Temperature : On travel 02 temperature increased over the set point from 5 °C To 15 °C",
    "boatId": 4
  },
  {"pendingalerid": 6, "travelId": 1, "message": "bad request3", "boatId": 5},
];

class PendingAlert {
  int pendingalertId;
  int travelId;
  int boatId;
  int ta;
  int ua;
  int wa;
  int sus;
  DateTime date;
  String message;
  PendingAlert(
      {this.pendingalertId,
      this.travelId,
      this.message,
      this.boatId,
      this.date,
      this.sus,
      this.ta,
      this.ua,
      this.wa});
  factory PendingAlert.fromJson(Map<String, dynamic> json) => PendingAlert(
      pendingalertId: json["id"],
      travelId: json["journey_id"],
      message: json["descr"],
      boatId: json["boat_id"],
      wa: json["wa"],
      ua: json["ua"],
      ta: json["ta"],
      sus: json["sus"],
      date: json["dt"]);
}

class PendingAlerts {
  List<PendingAlert> pendingalerts = [];
  PendingAlerts();
  PendingAlerts.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      PendingAlert pendingalert = PendingAlert.fromJson(item);

      pendingalerts.add(pendingalert);
    }
  }
}
