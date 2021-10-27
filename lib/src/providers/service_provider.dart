import 'dart:convert';

import 'package:practica_1_180012/src/models/serviceModel.dart';
import 'package:http/http.dart' as http;

class ServiceProvider {
  String _url = 'practica-1-180012-git-master-edgar0710.vercel.app';

  Future<List<Service>> getServices() async {
    final url = Uri.https(_url, '/');
    final resp =
        await http.get(url, headers: {"Content-Type": "application/json"});

    //decodificar
    final decodeData = json.decode(resp.body);

    return new Services.fromJsonList(decodeData[0]).services;
  }
}
