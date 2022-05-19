import 'package:flutter/material.dart';
import '../layout/app_layout.dart';

class HewanDashboard extends StatelessWidget {
  const HewanDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: AppLayout(
                content: Container(
      child: Column(children: [Text("dahboard belum dibuat")]),
    ))));
  }
}
