// To parse this JSON data, do
//
//     final files = filesFromJson(jsonString);

import 'dart:convert';

Files filesFromJson(String str) => Files.fromJson(json.decode(str));

String filesToJson(Files data) => json.encode(data.toJson());

class Files {
  Files({
    this.files,
    this.message,
    this.status,
    this.code,
  });

  List<FileElement> files;
  String message;
  String status;
  int code;

  factory Files.fromJson(Map<String, dynamic> json) => Files(
        files: List<FileElement>.from(
            json["FILES"].map((x) => FileElement.fromJson(x))),
        message: json["message"],
        status: json["status"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "FILES": List<dynamic>.from(files.map((x) => x.toJson())),
        "message": message,
        "status": status,
        "code": code,
      };
}

class FileElement {
  FileElement({
    this.id,
    this.flName,
    this.flType,
    this.flPath,
    this.flUrl,
    this.journeyId,
    this.boatId,
    this.cam,
    this.rl,
    this.rt,
    this.dt,
    this.reg,
  });

  int id;
  String flName;
  String flType;
  String flPath;
  String flUrl;
  int journeyId;
  int boatId;
  int cam;
  dynamic rl;
  dynamic rt;
  String dt;
  String reg;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        flName: json["fl_name"],
        flType: json["fl_type"],
        flPath: json["fl_path"],
        flUrl: json["fl_url"],
        journeyId: json["journey_id"],
        boatId: json["boat_id"],
        cam: json["cam"],
        rl: json["rl"],
        rt: json["rt"],
        dt: json["dt"],
        reg: json["reg"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fl_name": flName,
        "fl_type": flType,
        "fl_path": flPath,
        "fl_url": flUrl,
        "journey_id": journeyId,
        "boat_id": boatId,
        "cam": cam,
        "rl": rl,
        "rt": rt,
        "dt": dt,
        "reg": reg,
      };
}
