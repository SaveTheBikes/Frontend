import 'package:flutter/material.dart';
import 'package:frontend/reqs.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/maps_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Profile> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = getProfile();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return MapsPage();
          }));
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.report)),
        IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return ProfilePage();
                }));
              },
              icon: Icon(Icons.person)),
      ],
      title: Text('Profile'),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    ),
    body: Center(
      child: FutureBuilder<Profile>(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Profile profile = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/user.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text('Name: ${profile.username}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Divider(color: Colors.grey),
                      SizedBox(height: 8),
                      Text('Email: ${profile.email}', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {}, 
                        child: Text('Add Bike'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // background
                          foregroundColor: Colors.white, // foreground
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

            
            /*
            Profile profile = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/user.png"),
                      ),
                      SizedBox(height: 16),
                      Text('Name: ${profile.username}', style: TextStyle(fontSize: 20)),
                      SizedBox(height: 8),
                      Text('Email: ${profile.email}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 16),
                      ElevatedButton(onPressed: () {}, child: Text('Add Bike')),
                    ],
                  ),
                ),
              ),
            );*/
          }
        },
      ),
    ),
  );
}
}