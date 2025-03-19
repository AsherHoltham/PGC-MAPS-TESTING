import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Maps(),
    );
  }
}

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => MapState();
}

class MapState extends State<Maps> {
  late GoogleMapController mapController;
  final List<Marker> _markers = [];
  bool showMap = true;

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: MarkerId("myLocation"),
        position: LatLng(26.78688, 25.76393),
      ),
    );
    // In this case, showMap is already true, so setState is not strictly necessary here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: showMap
            ? Container(
                height: 500,
                width: 1230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GoogleMap(
                  onMapCreated: (controller) {
                    setState(() {
                      mapController = controller;
                    });
                  },
                  markers: Set<Marker>.of(_markers),
                  mapType: MapType.terrain,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(26.78688, 25.76393),
                    zoom: 13,
                  ),
                ),
              )
            : const CircularProgressIndicator(color: Colors.amber),
      ),
    );
  }
}
