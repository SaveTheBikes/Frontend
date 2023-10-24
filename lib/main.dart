import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SaveTheBikes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 77, 145, 245),
        fontFamily: 'Arizona',
        useMaterial3: true,
        textTheme: const TextTheme(
        displayLarge:  TextStyle(
        fontSize:72,
        fontWeight: FontWeight.bold
        )
        )


      ),
      home: const HomePage(),
    );
  }
}


