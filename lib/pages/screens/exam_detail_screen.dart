import 'package:flutter/material.dart';
import '../../modals/personelDetayGetir.dart';

class ExaminationDetailScreen extends StatefulWidget {
  final PersonelDetayGetirModel personelDetails;

  ExaminationDetailScreen({this.personelDetails});

  @override
  _ExaminationDetailScreenState createState() => _ExaminationDetailScreenState();
}

class _ExaminationDetailScreenState extends State<ExaminationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Muayene İşlemleri - ' + widget.personelDetails.perAdSoyad),
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
        child: Text("Muayene Ekle", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
