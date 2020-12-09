import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../modals/personelGetirAnaSayfa.dart';
import '../../constants.dart';
import '../../functions.dart';
import '../../services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<personelGetirAnaSayfaModal> _personeller =
      List<personelGetirAnaSayfaModal>();
  bool isHaveData = false;



  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPersonelGetirAnaSayfa().then((value) {
      setState(() {
        _personeller.addAll(value);
        isHaveData=true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isHaveData
          ? Column(
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    textCapitalization: TextCapitalization.characters,
                    onChanged: (value) {
                      //filterSearchResults(value);
                    },
                    controller: editingController,
                    decoration: InputDecoration(
                      labelText: "Ara",
                      hintText: "İsim Soyisim",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: _personeller.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            //
                          },
                          leading: Icon(Icons.person),
                          trailing: Icon(Icons.keyboard_arrow_right_sharp),
                          title: Text('TC NO : ' + _personeller[index].perTc),
                          subtitle: Text(_personeller[index].perAd +
                              ' ' +
                              _personeller[index].perSoyad),
                          dense: true,
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : CircularProgressIndicator(),
    );
  }
}
