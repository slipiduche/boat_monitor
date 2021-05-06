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

class Journey {
  int boatId;
  String dateArrived;
  String dateDeparture;
  String status;

  Journey({this.boatId, this.dateArrived, this.dateDeparture, this.status});
  factory Journey.fromJson(Map<String, dynamic> json) => Journey(
      boatId: json["boatId"],
      dateArrived: json["dateArrived"],
      dateDeparture: json["dateArrived"],
      status: json["dateArrived"]);
}

class Journeys {
  List<Journey> journeys = [];
  Journeys();
  Journeys.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      Journey journey = Journey.fromJson(item);

      journeys.add(journey);
    }
  }
  List<Journey> get getJourneys {
    Journeys.fromJsonList(journeysTest);

    return journeys;
  }
}
