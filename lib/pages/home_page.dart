import 'package:flutter/material.dart';
import 'package:isgapp/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("ISG APP", style: TextStyle(color: Colors.white)),

        actions: <Widget>[
          FlatButton(
            onPressed: () {
              clearPref();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
            child: Text("Çıkış", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Center(child: Text("Ana Sayfa")),
      //drawer: Drawer(),
    );
  }

  Future clearPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
