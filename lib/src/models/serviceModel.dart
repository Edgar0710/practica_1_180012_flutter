import 'dart:convert';

List<Service> serviceFromJson(String str) =>
    List<Service>.from(json.decode(str).map((x) => Service.fromJson(x)));

class Services {
  List<Service> services = [];
  Services();
  Services.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final service = new Service.fromJson(item);
      services.add(service);
    }
  }
}

String serviceToJson(List<Service> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Service {
  Service({
    this.seId,
    this.sePrecio,
    this.seEstatus,
    this.seDescripcion,
    this.usId,
    this.seNombre,
  });

  int seId;
  int sePrecio;
  dynamic seEstatus;
  String seDescripcion;
  int usId;
  String seNombre;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        seId: json["se_id"],
        sePrecio: json["se_precio"],
        seEstatus: json["se_estatus"],
        seDescripcion: json["se_descripcion"],
        usId: json["us_id"],
        seNombre: json["se_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "se_id": seId,
        "se_precio": sePrecio,
        "se_estatus": seEstatus,
        "se_descripcion": seDescripcion,
        "us_id": usId,
        "se_nombre": seNombre,
      };
}
