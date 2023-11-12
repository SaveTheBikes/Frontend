import 'package:http/http.dart' as http;
import 'dart:convert';

String url = "http://127.0.0.1:5000";

Map<String, String> headers = {"Content-type": "application/json"};

Future<bool> login(String email, String password) async {
  var payLoad = {"email": email, "password": password};

  String body = jsonEncode(payLoad);
  final response = await http.post(Uri.parse("$url/auth/login"),
      headers: headers, body: body);
  var res = jsonDecode(response.body)["access_token"];
  return true;
}

Future<bool> register(String email, String username, String password) async {
  var payLoad = {"email": email, "username": username, "password": password};

  String body = jsonEncode(payLoad);
  final response = await http.post(Uri.parse("$url/auth/register"),
      headers: headers, body: body);
  var res = jsonDecode(response.body)["registered"];
  return bool.parse(res);
}
