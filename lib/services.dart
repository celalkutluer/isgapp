import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import './constants.dart';
import './modals/personelGetirAnaSayfa.dart';
import './functions.dart';



Future<List<personelGetirAnaSayfaModal>> getPersonelGetirAnaSayfa() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var _url =
      "$BASE_URL?kul_id=${sharedPreferences.getString("kul_id")}&kul_token=${sharedPreferences.getString("token")}&securityKey=${timeEncode()}&islem=PersonelGetirAnaSayfa";
  final _response = await http.get(_url);
  var personeller = List<personelGetirAnaSayfaModal>();
  if (_response.statusCode == 200) {
    final _mapJson = json.decode(_response.body);
    for (var _mapJson in _mapJson) {
      personeller.add(personelGetirAnaSayfaModal.fromJson(_mapJson));
    }
    return personeller;
  } else {
    throw Exception('Failed to load jobs from API');
  }
}