import 'package:flutter/material.dart';
import 'package:practica_1_180012/src/models/serviceModel.dart';
import 'package:practica_1_180012/src/providers/service_provider.dart';

class HomePage extends StatelessWidget {
  final ServiceProvider serviceProvider = new ServiceProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Servicios"),
        backgroundColor: Colors.blueAccent,
      ),
      body: _services(context),
    );
  }

  _services(BuildContext context) {
    return FutureBuilder(
      future: serviceProvider.getServices(),
      builder: (BuildContext context, AsyncSnapshot<List<Service>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Service se = snapshot.data[index];
              return Card(
                child: ListTile(
                  title: Text(se.seNombre),
                  onTap: () => {},
                  subtitle: Text('Precio: ${se.sePrecio}'),
                ),
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
