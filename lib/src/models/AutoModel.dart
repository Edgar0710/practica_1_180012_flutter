// To parse this JSON data, do
//
//     final auto = autoFromJson(jsonString);

import 'dart:convert';

List<Auto> autoFromJson(String str) =>
    List<Auto>.from(json.decode(str).map((x) => Auto.fromJson(x)));

String autoToJson(List<Auto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Auto {
  Auto({
    this.auId,
    this.auModelo,
    this.auMatricula,
    this.auColor,
    this.clId,
    this.auTipo,
  });

  int auId;
  dynamic auModelo;
  dynamic auMatricula;
  dynamic auColor;
  int clId;
  String auTipo;

  factory Auto.fromJson(Map<String, dynamic> json) => Auto(
        auId: json["au_id"],
        auModelo: json["au_modelo"],
        auMatricula: json["au_matricula"],
        auColor: json["au_color"],
        clId: json["cl_id"],
        auTipo: json["au_Tipo"],
      );

  Map<String, dynamic> toJson() => {
        "au_id": auId,
        "au_modelo": auModelo,
        "au_matricula": auMatricula,
        "au_color": auColor,
        "cl_id": clId,
        "au_Tipo": auTipo,
      };
}
