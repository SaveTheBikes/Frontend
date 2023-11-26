import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

String url = "https://wetca.ca/serenity";

Map<String, String> headers = {"Content-type": "application/json"};

Future<bool> login(String email, String password) async {
  var payLoad = {"email": email, "password": password};

  String body = jsonEncode(payLoad);
  final response = await http.post(Uri.parse("$url/auth/login"),
      headers: headers, body: body);
  var res = jsonDecode(response.body);

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('access_token', res["access_token"]);
  await prefs.setInt('userID', res["userID"]);

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

Future<Map<String, String>> header_with_token() async {
  Map<String, String> h = Map.from(headers);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('access_token') ?? "";
  h["Authorization"] = "Bearer $token";
  return h;
}

Future<bool> verify_token() async {
  final response = await http.get(Uri.parse("$url/auth/verify"),
      headers: await header_with_token());
  print(response.reasonPhrase);
  return response.statusCode == 200;
}
Future<bool> report_bike(String title, String model, String colour, DateTime date, File image) async {
  final response = await http.post(Uri.parse("$url/bikes/addBike"),
  headers: await header_with_token());
  return true;

}

class Bike {
  String colour;
  DateTime dateStolen;
  String model;
  String picture;
  String title;
  double lat;
  String phone;
  int id;
  double lon;
  Bike(
      {required this.colour,
      required this.dateStolen,
      required this.model,
      required this.picture,
      required this.title,
      required this.lat,
      required this.lon,
      required this.phone,
      required this.id});
  factory Bike.fromJson(Map<String, dynamic> json) {
    print(json['id']);
    return Bike(
        colour: json['colour'],
        dateStolen: parseDateString(json['datestolen']),
        model: json['model'],
        picture: json['picture'],
        title: json['title'],
        lat: json['locationlat'],
        lon: json['locationlon'],
        phone: json['phonenumber'],
        id: json['id']);
  }
  static List<Bike> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((bikeJson) => Bike.fromJson(bikeJson)).toList();
  }
}

Future<List<Bike>> bikes() async {
  final response = await http.get(Uri.parse("$url/bikes/allBikes"),
      headers: await header_with_token());
  List<dynamic> jsonList = json.decode(response.body);
  List<Bike> bikes = Bike.listFromJson(jsonList);
  return bikes;
}

DateTime parseDateString(String dateString) {
  // Define the expected date format
  DateFormat dateFormat = DateFormat("E, d MMM y H:m:s 'GMT'");

  // Parse the date string
  return dateFormat.parse(dateString);
}

