import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:practica_1_180012/src/models/clientModel.dart';

class UserProvider {
  String _url = 'edkertect.xyz';
  final clienthttp = RetryClient(http.Client());

  Future<Client> login(String user, String pwd) async {
    final url = Uri.https(_url, '/carwash.api/api/Usuarios/LoginCliente', {
      'email': user,
      'password': base64.encode(utf8.encode(pwd)),
    });
    print(url);
    final resp = await clienthttp
        .post(url, headers: {"Content-Type": "application/json"});

    print(resp.statusCode);
    //decodificar

    if (resp.statusCode != 200) return null;
//////////////////////////////////////////////
    final decodeData = json.decode(resp.body);
    return Client.fromJson(decodeData["result"]);
  }
}
