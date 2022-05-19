import 'package:erpdtpeduli/controllers/login.dart';
import 'package:flutter/material.dart';
import '../layout/app_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  static const route = "/profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isInit = true;
  bool isLoading = false;
  String? token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: AppLayout(
        content: Row(
          children: [
            IconButton(onPressed: () => logout(), icon: Icon(Icons.logout)),
            Text('Logout')
          ],
        ),
      )),
    );
  }

  Future logout() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    await userData.clear();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
