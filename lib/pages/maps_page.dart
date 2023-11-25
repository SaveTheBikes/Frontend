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
        onTap: (_){
        Navigator.pop(context);
        },
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
          onTap: (){
          showBikeDetailsBottomSheet(context, bike);

          }
        
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
              Text('ID: ${bike.id}'),
              // Add more bike details as needed
            ],
          ),
        );
      },
    );
  }
}

