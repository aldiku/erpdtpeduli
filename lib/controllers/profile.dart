import 'package:flutter/material.dart';
import '../layout/app_layout.dart';

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
            Text("hello Profile"),
          ],
        ),
      )),
    );
  }
}
