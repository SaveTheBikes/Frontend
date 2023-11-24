import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng loc = LatLng(25.1193, 55.3773);

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);
  @override
  State<MapsPage> createState() => MapsPageState();
}

class MapsPageState extends State<MapsPage> {
  Set<Marker> markers = {};
  @override
    void initState() {
      bikeMarkers();
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: GoogleMap(initialCameraPosition: CameraPosition(target: loc),
        markers: markers
        ));
        
  }
  void bikeMarkers(){}
}
