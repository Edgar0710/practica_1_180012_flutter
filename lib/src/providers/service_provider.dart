import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:practica_1_180012/src/models/serviceModel.dart';

class ServiceProvider {
  String _url = 'edkertect.xyz';
  final clienthttp = RetryClient(http.Client());

  Future<List<Service>> getServices() async {
    final url = Uri.https(_url, '/carwash.api/api/Services/Servicios');

    final resp = await clienthttp
        .read(url, headers: {"Content-Type": "application/json"});

    //decodificar
    final decodeData = json.decode(resp);
    //print(decodeData["result"]);
    return new Services.fromJsonList(decodeData["result"]).services;
  }
}
