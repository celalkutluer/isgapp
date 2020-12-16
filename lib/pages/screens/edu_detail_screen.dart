import 'package:flutter/material.dart';
import '../../modals/personelDetayGetir.dart';

class EducationDetailScreen extends StatefulWidget {
  final PersonelDetayGetirModel personelDetails;

  EducationDetailScreen({this.personelDetails});

  @override
  _EducationDetailScreenState createState() => _EducationDetailScreenState();
}

class _EducationDetailScreenState extends State<EducationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eğitim İşlemleri - ' + widget.personelDetails.perAdSoyad),
      ),
      body: Center(
          child: Column(
        children: [buttonSection()],
      )),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: () {},
        // elevation: 0.0,
        color: Colors.blue,
        child: Text("Eğitim Ekle", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
