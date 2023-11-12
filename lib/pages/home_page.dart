import 'package:flutter/material.dart';
import 'package:frontend/pages/maps_page.dart';
import 'package:frontend/reqs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Text("Save The Bikes",
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center),
            const Spacer(flex: 2),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username or Email',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(150, 60)),

                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context)
                          .primaryColor
                          .withOpacity(1)), // Set the background color
                ),
                onPressed: () {
                  login(nameController.text, passwordController.text)
                      .then((success) {
                    if (success) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MapsPage()));
                    }
                  });
                },
                child:
                    const Text("Login", style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(150, 60)),

                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context)
                          .primaryColor
                          .withOpacity(1)), // Set the background color
                ),
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ()));
                },
                child: const Text("Register",
                    style: TextStyle(color: Colors.black)),
              ),
            ),
            const Spacer(flex: 2)
          ],
        ),
      )),
    );
  }
}
