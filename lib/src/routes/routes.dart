import 'package:flutter/material.dart';
import 'package:practica_1_180012/src/pages/home_page.dart';
import 'package:practica_1_180012/src/pages/login.dart';
import 'package:practica_1_180012/src/states/login_state.dart';
import 'package:provider/provider.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) {
      var state = Provider.of<LoginState>(context);
      return state.isLoggedIn() ? HomePage() : Login();
    },
    "home": (BuildContext context) => HomePage(),
    'Login': (BuildContext context) => Login()
  };
}
