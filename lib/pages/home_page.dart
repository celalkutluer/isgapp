import 'package:flutter/material.dart';
import './login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import './screens/home_screen.dart';
import './screens/edu_screen.dart';
import './screens/exam_screen.dart';
import './screens/vaccine_screen.dart';
import './screens/def_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences sharedPreferences;
  int _currentIndex = 0;

  final tabs = [
    HomeScreen(),
    EducationScreen(),
    ExaminationScreen(),
    VaccineScreen(),
    DefinitionScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.home),
              label: 'Anasayfa'),
          BottomNavigationBarItem(
            backgroundColor: Colors.blueGrey,
            icon: Icon(Icons.school),
            label: 'Eğitim İşlemleri',
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.teal,
              icon: Icon(MdiIcons.stethoscope),
              label: 'Muayene İşlemleri'),
          BottomNavigationBarItem(
              backgroundColor: Colors.lightBlue,
              icon: Icon(MdiIcons.needle),
              label: 'Aşı İşlemleri'),
          BottomNavigationBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(Icons.settings),
              label: 'Tanımlamalar'),
          BottomNavigationBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(Icons.exit_to_app),
              label: 'Çıkış'),
        ],
        onTap: (index) {
          setState(() {
            if (index != 5) {
              _currentIndex = index;
            } else {
              clearPref();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                      (Route<dynamic> route) => false);
            }
          });
        },
      ),
      //drawer: Drawer(),
    );
  }


  Future clearPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
