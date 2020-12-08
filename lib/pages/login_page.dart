import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:basic_utils/basic_utils.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.indigo.shade600],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              headerSection(),
              textSection(),
              buttonSection(),
            ],
          ),
        ),
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Center(
        child: Text("GİRİŞ YAP",
            style: TextStyle(
                color: Colors.white70,
                fontSize: 40.0,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: "Email Adresi",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: "Şifre",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: OutlineButton(
        onPressed: () {
          if (emailController.text == "" || passwordController.text == "") {
          } else {
            setState(() {
              _isLoading = true;
            });
            signIn(emailController.text, passwordController.text);
          }
        },
        // elevation: 0.0,
        color: Colors.purple,
        child: Text("Giriş Yap", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  encodePass(String pass) {
    var bytes = utf8
        .encode(md5.convert(utf8.encode(pass)).toString()); // data being hashed
    var digest = sha256.convert(bytes); // Hashing Process
    return base64Encode(utf8.encode(digest.toString()));
  }

  timeEncode() {
    var zaman = DateTime.now().millisecondsSinceEpoch.toString();
    for (var i = 0; i < 3; i++) {
      zaman = base64Encode(utf8.encode(zaman));
      zaman = StringUtils.addCharAtPosition(zaman, "c", 3);
    }
    return zaman;
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url =
        "http://celalkutluer.com.tr/services.php?kul_eposta=${base64Encode(utf8.encode(email))}&kul_sifre=${encodePass(pass)}&securityKey=${timeEncode()}";
    var response = await http.get(url);
    print(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['isLogin'] == true) {
        sharedPreferences.setString("token", jsonResponse['token']);
        sharedPreferences.setString("kul_id", jsonResponse['kul_id']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
                (Route<dynamic> route) => false);
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

}
