// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
  Client({
    this.clId,
    this.clNombre,
    this.clApellidoMaterno,
    this.clApellidoPaterno,
    this.clDireccion,
    this.clEmail,
    this.clTelefono,
    this.clAthorization,
  });

  int clId;
  dynamic clNombre;
  dynamic clApellidoMaterno;
  dynamic clApellidoPaterno;
  dynamic clDireccion;
  String clEmail;
  dynamic clTelefono;
  String clAthorization;
  String clPassword;
  factory Client.fromJson(Map<String, dynamic> json) => Client(
      clId: json["cl_id"],
      clNombre: json["cl_nombre"],
      clApellidoMaterno: json["cl_apellidoMaterno"],
      clApellidoPaterno: json["cl_apellidoPaterno"],
      clDireccion: json["cl_direccion"],
      clEmail: json["cl_email"],
      clTelefono: json["cl_telefono"],
      clAthorization: json["cl_athorization"]);

  Map<String, dynamic> toJson() => {
        "cl_id": clId,
        "cl_nombre": clNombre,
        "cl_apellidoMaterno": clApellidoMaterno,
        "cl_apellidoPaterno": clApellidoPaterno,
        "cl_direccion": clDireccion,
        "cl_email": clEmail,
        "cl_telefono": clTelefono,
        "cl_athorization": clAthorization,
      };
}
