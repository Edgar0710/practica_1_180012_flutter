import 'package:flutter/material.dart';
import 'package:practica_1_180012/src/models/clientModel.dart';
import 'package:practica_1_180012/src/providers/user_provider.dart';

class LoginState with ChangeNotifier {
  Client usuario;
  UserProvider _provider = new UserProvider();
  bool logeado = false;
  bool _loading = false;
  bool isLoggedIn() => logeado;
  bool isLoading() => _loading;
  Client userLogin() => usuario;
  void login({String email, String contrasenia}) async {
    _loading = true;
    notifyListeners();
    var user = await _provider.login(email, contrasenia);
    if (user != null) {
      logeado = true;
      usuario = user;
      notifyListeners();
    } else {
      logeado = false;
      _loading = false;
      notifyListeners();
    }
  }

  void logout() {
    logeado = false;
    _loading = false;
    notifyListeners();
  }
}
