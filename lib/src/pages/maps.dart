import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:practica_1_180012/src/models/citasModel.dart';
import 'package:practica_1_180012/src/utils/menu.dart';

class Maps extends StatefulWidget {
  final Cita cita;

  const Maps({this.cita});
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Marker autolavado;
  Cita cita;
  GoogleMapController _controller;
  Map<PolylineId, Polyline> lines = {};
  CameraPosition initialLocation;
  Set<Polyline> get polylines => lines.values.toSet();
  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    setPolylines(latlng);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("Auto"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  tilt: 0,
                  zoom: 18.00)));
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  void setPolylines(LatLng position) {
    setState(() {
      final PolylineId polylineId = PolylineId(cita.suNombre);
      Polyline polyline;
      if (lines.containsKey(polylineId)) {
        final tmp = lines[polylineId];
        polyline = tmp.copyWith(pointsParam: [...tmp.points, position]);
      } else {
        polyline = Polyline(polylineId: polylineId, points: [
          position,
          LatLng(cita.suLatitud, cita.suLongitud),
        ]);
      }
      lines[polylineId] = polyline;
    });
  }

  @override
  Widget build(BuildContext context) {
    cita = widget.cita;
    initialLocation = CameraPosition(
      target: LatLng(cita.suLatitud, cita.suLongitud),
      zoom: 14.4746,
    );

    autolavado = new Marker(
      markerId: MarkerId(cita.suNombre),
      position: LatLng(cita.suLatitud, cita.suLongitud),
      draggable: false,
      zIndex: 2,
      flat: true,
      anchor: Offset(0.5, 0.5),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Maps"),
      ),
      drawer: Menu(),
      body: GoogleMap(
        polylines: polylines,
        mapType: MapType.normal,
        initialCameraPosition: initialLocation,
        markers: Set.of((marker != null) ? [marker, autolavado] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          getCurrentLocation();
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          onPressed: () {
            getCurrentLocation();
          }),
    );
  }
}
