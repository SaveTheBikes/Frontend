import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

String url = "https://wetca.ca/serenity";

Map<String, String> headers = {"Content-type": "application/json"};

Future<bool> login(String email, String password) async {
  var payLoad = {"email": email, "password": password};

  String body = jsonEncode(payLoad);
  final response = await http.post(Uri.parse("$url/auth/login"),
      headers: headers, body: body);
  var res = jsonDecode(response.body)["access_token"];

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('access_token', res);

  return true;
}

Future<bool> register(String email, String username, String password) async {
  var payLoad = {"email": email, "username": username, "password": password};

  String body = jsonEncode(payLoad);
  print("register");
  final response = await http.post(Uri.parse("$url/auth/register"),
      headers: headers, body: body);
  var res = jsonDecode(response.body)["registered"];
  return bool.parse(res);
}

Future<Map<String, String>> header_with_token() async {
  Map<String, String> h = Map.from(headers);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('access_token') ?? "";
  h["Authorization"] = "Bearer $token";
  return h;
}

Future<bool> verify_token() async {
  

  print(await header_with_token());

  final response = await http.get(Uri.parse("$url/auth/verify"),
      headers: await header_with_token());
  return response.statusCode == 200;
}
