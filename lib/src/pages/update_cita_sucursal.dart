import 'package:flutter/material.dart';
import 'package:practica_1_180012/src/models/citasModel.dart';
import 'package:practica_1_180012/src/models/clientModel.dart';
import 'package:practica_1_180012/src/models/sucursalModel.dart';
import 'package:practica_1_180012/src/providers/service_provider.dart';
import 'package:practica_1_180012/src/states/login_state.dart';
import 'package:practica_1_180012/src/utils/menu.dart';
import 'package:provider/provider.dart';

class UpdateCitaSucursal extends StatefulWidget {
  final Cita cita;

  const UpdateCitaSucursal({Key key, this.cita}) : super(key: key);
  @override
  _UpdateCitaSucursalState createState() => _UpdateCitaSucursalState();
}

class _UpdateCitaSucursalState extends State<UpdateCitaSucursal> {
  Client cliente;
  ServiceProvider serviceProvider;
  Cita cita;
  @override
  Widget build(BuildContext context) {
    cliente = Provider.of<LoginState>(context).userLogin();
    serviceProvider = new ServiceProvider(cliente.clId, cliente.clAthorization);
    cita = widget.cita;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cambiar Sucursal"),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Menu(),
      body: _formulario(context),
    );
  }

  _formulario(BuildContext context) {
    return FutureBuilder(
      future: serviceProvider.getSucursales(),
      builder: (BuildContext context, AsyncSnapshot<List<Sucursal>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Sucursal s = snapshot.data[index];
              return Card(
                child: ListTile(
                    tileColor:
                        s.suId == cita.suId ? Colors.green[100] : Colors.white,
                    trailing: Column(
                      children: [
                        Text("latitud: ${s.suLatitud}"),
                        Text("longitud: ${s.suLongitud}"),
                      ],
                    ),
                    title: Center(child: Text(s.suNombre)),
                    leading: Text("# ${s.suId}"),
                    onTap: () {
                      if (s.suId == cita.suId) {
                        final snackBar = SnackBar(
                          content: const Text(
                              'No puede asignar de nuevo la misma sucursal'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        serviceProvider.actualizaSucursalCita(
                            cita.asId, s.suId);
                        Navigator.pushNamed(context, 'home');
                      }
                    }),
              );
            },
          );
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
