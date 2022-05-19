import 'package:flutter/material.dart';
import '../layout/app_layout.dart';
import '../controllers/hewan.dart';
import '/responsive.dart';

class HomePage extends StatefulWidget {
  static const route = "/home";
  void openhewan() {
    MaterialPageRoute(builder: (context) => HewanPage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = true;
  bool isLoading = false;
  String? token;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: AppLayout(
                content: Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Dashboard",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: Responsive.isMobile(context)
                  ? 3
                  : Responsive.isTablet(context)
                      ? 6
                      : 9,
              children: [
                MyMenu(
                  title: "Qurban Stat",
                  icon: Icons.pie_chart,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HewanPage()),
                    );
                  },
                ),
                MyMenu(
                  title: "List Hewan",
                  icon: Icons.bug_report,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HewanPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ))));
  }
}

class MyMenu extends StatelessWidget {
  const MyMenu(
      {Key? key, required this.title, required this.icon, required this.press})
      : super(key: key);

  final String title;
  final IconData icon;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Colors.blue[900],
        onTap: press,
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: Responsive.isMobile(context)
                  ? 50.0
                  : Responsive.isTablet(context)
                      ? 60.0
                      : 70.0,
              color: Colors.indigo.shade900,
            ),
            Text(
              title,
              style: new TextStyle(
                  fontSize: Responsive.isMobile(context) ? 13.0 : 15.0),
            )
          ],
        )),
      ),
    );
  }
}
