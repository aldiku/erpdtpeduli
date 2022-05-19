import 'package:flutter/material.dart';
import './controllers/login.dart';
import 'controllers/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  runApp(MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 216, 216, 216),
      ),
      home: token == null ? LoginScreen() : HomePage()));
}
