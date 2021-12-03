import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:practica_1_180012/src/models/AutoModel.dart';
import 'package:practica_1_180012/src/models/citasModel.dart';
import 'package:practica_1_180012/src/models/serviceModel.dart';

class ServiceProvider {
  String _url = 'edkertect.xyz';
  final clienthttp = RetryClient(http.Client());
  int id;
  String token;
  ServiceProvider(int id, String token) {
    this.id = id;
    this.token = token;
  }
  Future<List<Service>> getServices() async {
    final url = Uri.https(_url, '/carwash.api/api/Services/Servicios');

    final resp = await clienthttp
        .read(url, headers: {"Content-Type": "application/json"});

    //decodificar
    final decodeData = json.decode(resp);
    //print(decodeData["result"]);
    return new Services.fromJsonList(decodeData["result"]).services;
  }

  Future<List<Cita>> getCitas() async {
    final url = Uri.https(_url, '/carwash.api/api/Services/CitasCliente',
        {"cliente": id.toString()});

    final resp = await clienthttp.read(url, headers: {
      "Content-Type": "application/json",
    });

    //decodificar
    final decodeData = json.decode(resp);
    //print(decodeData["result"]);
    return new Citas.fromJsonList(decodeData["result"]).citas;
  }

  Future<List<Auto>> getAutos() async {
    final url = Uri.https(
        _url, '/carwash.api/api/Services/AutosCliente', {"cliente": id});

    final resp = await clienthttp
        .read(url, headers: {"Content-Type": "application/json"});

    //decodificar
    final decodeData = json.decode(resp);
    //print(decodeData["result"]);
    return autoFromJson(decodeData["result"]);
  }

  Future<bool> addCita(Cita cita) async {
    final url = Uri.https(_url, '/carwash.api/api/Services/CrearCita', {
      'auto': cita.auId,
      'servicio': cita.seId,
      'fecha': cita.asFecha,
      'hora': cita.asHora,
    });
    print(url);
    final resp = await clienthttp
        .post(url, headers: {"Content-Type": "application/json"});

    print(resp.statusCode);
    //decodificar

    if (resp.statusCode != 200) return false;
//////////////////////////////////////////////
    final decodeData = json.decode(resp.body);
    return true;
  }
}
