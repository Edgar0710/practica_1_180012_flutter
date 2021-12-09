// To parse this JSON data, do
//
//     final sucursal = sucursalFromJson(jsonString);

import 'dart:convert';

List<Sucursal> sucursalFromJson(String str) =>
    List<Sucursal>.from(json.decode(str).map((x) => Sucursal.fromJson(x)));

String sucursalToJson(List<Sucursal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sucursales {
  List<Sucursal> sucursales = [];
  Sucursales();
  Sucursales.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final service = new Sucursal.fromJson(item);
      sucursales.add(service);
    }
  }
}

class Sucursal {
  Sucursal({
    this.suId,
    this.suNombre,
    this.suLatitud,
    this.suLongitud,
  });

  int suId;
  String suNombre;
  double suLatitud;
  double suLongitud;

  factory Sucursal.fromJson(Map<String, dynamic> json) => Sucursal(
        suId: json["su_id"],
        suNombre: json["su_nombre"],
        suLatitud: json["su_latitud"].toDouble(),
        suLongitud: json["su_longitud"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "su_id": suId,
        "su_nombre": suNombre,
        "su_latitud": suLatitud,
        "su_longitud": suLongitud,
      };
}
