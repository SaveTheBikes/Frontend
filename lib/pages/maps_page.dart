import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/profile_page.dart';
import 'package:frontend/pages/report_bike_dialog.dart';
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
                    logout();

                  return LoginPage();
                }));
              },
              icon: Icon(Icons.logout)),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ReportBikeDialog();
                      });
                },
                icon: Icon(Icons.report)),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProfilePage();
                  }));
                },
                icon: Icon(Icons.person))
          ],
          
        ),
        body: currentPosition != null
            ? GoogleMap(
                onTap: (_) {
                  Navigator.pop(context);
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currentPosition!.latitude, currentPosition!.longitude),
                    zoom: 10),
                markers: markers)
            : Center(child: CircularProgressIndicator()));
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
            snippet: 'Stolen:${bike.dateStolen}',
            onTap: () {
              showBikeDetailsBottomSheet(context, bike);
            }),
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
        print(position.latitude);
        print(position.longitude);
        currentPosition = position;
      });
    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  void showBikeDetailsBottomSheet(BuildContext context, Bike bike) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Bike Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Title: ${bike.title}'),

              Text("Date Stolen: ${bike.dateStolen}"),
              Text("Model: ${bike.model}"),
              Text("Colour: ${bike.colour}"),
              Text("Contact: ${bike.phone}"),
              Expanded(child: 
              Image.memory(base64Decode(bike.picture),fit:BoxFit.fill)

              )

              // Add more bike details as needed
            ],
          ),
        );
      },
    );
  }
}
