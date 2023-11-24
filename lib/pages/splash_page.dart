import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/maps_page.dart';
import 'package:frontend/reqs.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2)).then((value) {
      verify_token().then((value) {
        if (value) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MapsPage()));
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // You can customize the appearance of your splash screen here
      body: Center(
        child: FlutterLogo(size: 150),
      ),
    );
  }
}
