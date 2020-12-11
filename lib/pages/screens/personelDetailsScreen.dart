import 'package:flutter/material.dart';
import '../../modals/personelGetirAnaSayfa.dart';

class PersonelDetailScreen extends StatelessWidget {

  final HomeScreenPersonelGetirModel personelDetails;

  PersonelDetailScreen({this.personelDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('ISGAPP'),), body: Center(child: Text(personelDetails.perAdSoyad),),);
  }
}
