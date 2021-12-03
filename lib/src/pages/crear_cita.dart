import 'package:flutter/material.dart';
import 'package:practica_1_180012/src/models/AutoModel.dart';
import 'package:practica_1_180012/src/models/citasModel.dart';
import 'package:practica_1_180012/src/models/clientModel.dart';
import 'package:practica_1_180012/src/models/serviceModel.dart';
import 'package:practica_1_180012/src/providers/service_provider.dart';
import 'package:practica_1_180012/src/states/login_state.dart';
import 'package:practica_1_180012/src/utils/menu.dart';
import 'package:provider/provider.dart';

class crearCita extends StatefulWidget {
  @override
  _crearCitaState createState() => _crearCitaState();
}

class _crearCitaState extends State<crearCita> {
  Client cliente;
  ServiceProvider serviceProvider;
  final formKey = GlobalKey<FormState>();
  final cita = new Cita();
  List<Auto> listAutos;
  List<Services> lsitServices;
  @override
  Widget build(BuildContext context) {
    cliente = Provider.of<LoginState>(context).userLogin();
    serviceProvider = new ServiceProvider(cliente.clId, cliente.clAthorization);
    return Scaffold(
      appBar: AppBar(
        title: Text("Añadir Citas"),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Menu(),
      body: _formulario(context),
    );
  }

  _formulario(BuildContext context) {
    return Column(children: []);
  }
}
