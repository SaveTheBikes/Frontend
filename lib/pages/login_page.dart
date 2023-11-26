import 'package:flutter/material.dart';
import 'package:frontend/pages/maps_page.dart';
import 'package:frontend/pages/register_page.dart';
import 'package:frontend/reqs.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Image.asset("assets/logo.png"),
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
              width: MediaQuery.of(context).size.width / 2,
              child: ElevatedButton(
                style: ButtonStyle(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text("Sign up")),
              ],
            ),
            const Spacer(flex: 3)
          ],
        ),
      )),
    );
  }
}
