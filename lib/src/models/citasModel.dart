import 'dart:convert';

List<Cita> citaFromJson(String str) =>
    List<Cita>.from(json.decode(str).map((x) => Cita.fromJson(x)));

String citaToJson(List<Cita> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Citas {
  List<Cita> citas = [];
  Citas();
  Citas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final service = new Cita.fromJson(item);
      citas.add(service);
    }
  }
}

class Cita {
  Cita({
    this.asId,
    this.auId,
    this.seId,
    this.asFecha,
    this.usId,
    this.asPagado,
    this.asMonto,
    this.asAprobado,
    this.asHora,
    this.auModelo,
    this.auMatricula,
    this.auColor,
    this.clId,
    this.auTipo,
    this.sePrecio,
    this.seEstatus,
    this.seDescripcion,
    this.seNombre,
  });

  int asId;
  int auId;
  int seId;
  DateTime asFecha;
  int usId;
  int asPagado;
  double asMonto;
  int asAprobado;
  String asHora;
  dynamic auModelo;
  dynamic auMatricula;
  dynamic auColor;
  int clId;
  String auTipo;
  double sePrecio;
  dynamic seEstatus;
  String seDescripcion;
  String seNombre;

  factory Cita.fromJson(Map<String, dynamic> json) => Cita(
        asId: json["as_id"],
        auId: json["au_id"],
        seId: json["se_id"],
        asFecha: DateTime.parse(json["as_fecha"]),
        usId: json["us_id"],
        asPagado: json["as_pagado"] == null ? null : json["as_pagado"],
        asMonto: json["as_monto"] == null ? null : json["as_monto"],
        asAprobado: json["as_aprobado"],
        asHora: json["as_hora"],
        auModelo: json["au_modelo"],
        auMatricula: json["au_matricula"],
        auColor: json["au_color"],
        clId: json["cl_id"],
        auTipo: json["au_tipo"],
        sePrecio: json["se_precio"],
        seEstatus: json["se_estatus"],
        seDescripcion: json["se_descripcion"],
        seNombre: json["se_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "as_id": asId,
        "au_id": auId,
        "se_id": seId,
        "as_fecha": asFecha.toIso8601String(),
        "us_id": usId,
        "as_pagado": asPagado == null ? null : asPagado,
        "as_monto": asMonto == null ? null : asMonto,
        "as_aprobado": asAprobado,
        "as_hora": asHora,
        "au_modelo": auModelo,
        "au_matricula": auMatricula,
        "au_color": auColor,
        "cl_id": clId,
        "au_tipo": auTipo,
        "se_precio": sePrecio,
        "se_estatus": seEstatus,
        "se_descripcion": seDescripcion,
        "se_nombre": seNombre,
      };

  bool isCancelled() {
    return asAprobado == 1;
  }

  String isPAgado() {
    return asPagado == 1 ? "Pagado" : "Pendiente de Pago";
  }

  String formattedDay() => '${asFecha.day}/${asFecha.month}/${asFecha.year}';
  String urlToCalendar() {
    String strDate =
        "${asFecha.year}${asFecha.month}${asFecha.day}T${asHora.replaceAll(":", "")}";
    String url =
        'https://calendar.google.com/calendar/render?action=TEMPLATE&text=Cita%20lavado%20de%20auto&details=CarWash&location=Carwash&dates=${strDate}/${strDate}&ctz=Central+Time';

    return url;
  }
}
