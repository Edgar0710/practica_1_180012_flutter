import 'package:flutter/material.dart';
import 'package:practica_1_180012/src/models/citasModel.dart';
import 'package:practica_1_180012/src/models/clientModel.dart';
import 'package:practica_1_180012/src/pages/maps.dart';
import 'package:practica_1_180012/src/pages/update_cita_sucursal.dart';
import 'package:practica_1_180012/src/providers/service_provider.dart';
import 'package:practica_1_180012/src/states/login_state.dart';
import 'package:practica_1_180012/src/utils/menu.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  Client cliente;
  ServiceProvider serviceProvider;
  @override
  Widget build(BuildContext context) {
    cliente = Provider.of<LoginState>(context).userLogin();
    serviceProvider = new ServiceProvider(cliente.clId, cliente.clAthorization);
    return Scaffold(
      appBar: AppBar(
        title: Text("Citas"),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Menu(),
      body: _misCitas(context),
    );
  }

  _misCitas(BuildContext context) {
    return FutureBuilder(
      future: serviceProvider.getCitas(),
      builder: (BuildContext context, AsyncSnapshot<List<Cita>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Cita c = snapshot.data[index];
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                child: Card(
                  child: ListTile(
                    tileColor:
                        c.isCancelled() ? Colors.red[100] : Colors.green[100],
                    trailing: Column(
                      children: [
                        Text(c.formattedDay().toString() + " " + c.asHora),
                        Text("Sucursal: ${c.suNombre}"),
                      ],
                    ),
                    title: Center(child: Text(c.seNombre)),
                    subtitle: Center(child: Text(c.isPAgado())),
                    leading: Text("# ${c.asId}"),
                  ),
                ),
                secondaryActions: [
                  IconSlideAction(
                    caption: 'Agregar al Calendario',
                    color: Colors.blueAccent,
                    icon: Icons.calendar_today,
                    onTap: () => {_openCalendar(c.urlToCalendar())},
                  ),
                  IconSlideAction(
                    caption: 'Ver mapa',
                    color: Colors.blue,
                    icon: Icons.map_sharp,
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Maps(cita: c)))
                    },
                  ),
                  IconSlideAction(
                    caption: 'Cambiar Sucursal',
                    color: Colors.green,
                    icon: Icons.local_taxi_outlined,
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UpdateCitaSucursal(cita: c)))
                    },
                  ),
                ],
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

  _openCalendar(String url) async {
    await launch(url);
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}
