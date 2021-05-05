final pendingApprovalsTest = [
  {"pendingalerid": 1, "travelId": 2, "message": "boat 1 decrase weight : on travel 01 18:00 Weight decreased from 700 KG to 600 KG", "boatId": 4},
  {"pendingalerid": 3, "travelId": 5, "message": "boat 1 increase Temperature : On travel 02 temperature increased over the set point from 5 °C To 15 °C", "boatId": 4},
  {"pendingalerid": 6, "travelId": 1, "message": "bad request3", "boatId": 5},
];

class PendingApproval {
  int pendingapprovalId;
  int travelId;
  int boatId;
  String message;
  PendingApproval({this.pendingapprovalId, this.travelId, this.message, this.boatId});
  factory PendingApproval.fromJson(Map<String, dynamic> json) => PendingApproval(
      pendingapprovalId: json["pendingapprovalId"],
      travelId: json["travelId"],
      message: json["message"],
      boatId: json["boatId"]);
}

class PendingApprovals {
  List<PendingApproval> pendingapprovals = [];
  PendingApprovals();
  PendingApprovals.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      PendingApproval pendingapproval = PendingApproval.fromJson(item);

      pendingapprovals.add(pendingapproval);
    }
  }
  
}
