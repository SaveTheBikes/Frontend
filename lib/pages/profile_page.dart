import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
      ),
      body: Center(
      child:Column(
      children: [
      Text("Name:"),
      Text("Username:"),
      Text("Bikes"),
      TextButton(onPressed: (){}, child: Text("Add Bike"))

      ],
      )
      ),
    );
  }
}

