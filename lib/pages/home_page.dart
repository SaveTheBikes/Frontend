import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // You can declare your state variables here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(actions: [IconButton(onPressed: (){}, icon: Icon(Icons.person))]),
    );
  }
}
