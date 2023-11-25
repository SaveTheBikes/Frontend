import 'package:flutter/material.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/reqs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);
  @override
  State<MapsPage> createState() => MapsPageState();
}

class MapsPageState extends State<MapsPage> {
  Set<Marker> markers = {};
  Position? currentPosition;
  @override
  void initState() {
    getCurrentLocation();

    bikes().then((value) => bikeMarkers(value));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              icon: Icon(Icons.logout)),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.report)),
         IconButton(onPressed: (){}, icon: Icon(Icons.person)) ],
        ),
        body: currentPosition!=null ? GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(currentPosition!.latitude, currentPosition!.longitude)),
            markers: markers): Center(child:CircularProgressIndicator()));
  }

  void bikeMarkers(List<Bike> bikes) {
Set<Marker> newMarkers = {};

  for (var bike in bikes) {
      LatLng bikeLocation = LatLng(bike.lat, bike.lon);

      Marker marker = Marker(
        markerId: MarkerId(bike.id.toString()),
        position: bikeLocation,
        infoWindow: InfoWindow(
          title: bike.title,
          snippet: 'ID: ${bike.id}',
        ),
      );

      newMarkers.add(marker);
    }

  setState(() {
    markers = newMarkers;
  });
  }
void getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );

      setState(() {
        currentPosition = position;
      });
    } catch (e) {
      print("Error getting current location: $e");
    }
  }
}

