import 'dart:convert';

UserParameters userParametersFromJson(String str) =>
    UserParameters.fromJson(json.decode(str));

String userParametersToJson(UserParameters data) => json.encode(data.toJson());

class UserParameters {
  UserParameters({
    this.params,
  });

  List<Param> params;

  factory UserParameters.fromJson(Map<String, dynamic> json) => UserParameters(
        params: List<Param>.from(json["PARAMS"].map((x) => Param.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "PARAMS": List<dynamic>.from(params.map((x) => x.toJson())),
      };
}

class Param {
  Param({
    this.id,
    this.dweight,
    this.dtemp,
    this.timeOut,
    this.userId,
    this.dt,
  });

  int id;
  double dweight;
  double dtemp;
  double timeOut;
  int userId;
  DateTime dt;

  factory Param.fromJson(Map<String, dynamic> json) => Param(
        id: json["id"],
        dweight: json["dweight"].toDouble(),
        dtemp: json["dtemp"].toDouble(),
        timeOut: json["time_out"].toDouble(),
        userId: json["user_id"],
        dt: DateTime.parse(json["dt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dweight": dweight,
        "dtemp": dtemp,
        "time_out": timeOut,
        "user_id": userId,
        "dt": dt.toIso8601String(),
      };
}
