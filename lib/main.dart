import 'package:flutter/material.dart';
import 'package:practica_1_180012/src/pages/login.dart';
import 'package:practica_1_180012/src/routes/routes.dart';
import 'package:practica_1_180012/src/states/login_state.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginState>(
        create: (BuildContext context) => LoginState(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'CarWash',
            initialRoute: '/',
            routes: getAplicationRoutes(),
            onGenerateRoute: (settings) {
              print('Route Settings  ${settings.name}');
              return MaterialPageRoute(builder: (context) => Login());
            }));
  }
}
