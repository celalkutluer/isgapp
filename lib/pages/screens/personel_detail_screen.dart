import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:isgapp/pages/screens/edu_detail_screen.dart';
import 'package:isgapp/pages/screens/exam_detail_screen.dart';
import 'package:isgapp/pages/screens/vaccine_detail_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../modals/personelDetayGetir.dart';
import '../../services.dart';
import '../../widgets/flush_bar_widget.dart';
import '../../modals/personelGetirAnaSayfa.dart';

class PersonelDetailScreen extends StatefulWidget {
  final HomeScreenPersonelGetirModel personelDetails;

  PersonelDetailScreen({this.personelDetails});

  @override
  _PersonelDetailScreenState createState() => _PersonelDetailScreenState();
}

class _PersonelDetailScreenState extends State<PersonelDetailScreen> {
  List<PersonelDetayGetirModel> _personellerDetails =
      List<PersonelDetayGetirModel>();

  bool isHaveData = false;

  @override
  void initState() {
    super.initState();
    getPersonelDetayGetir(widget.personelDetails.id).then((value) {
      setState(() {
        isHaveData = true;
        _personellerDetails.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isHaveData) {
      getPersonelDetayGetir(widget.personelDetails.id).then((value) {
        setState(() {
          isHaveData = true;
          _personellerDetails.addAll(value);
        });
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Personel Detay - ' + widget.personelDetails.perAdSoyad),
      ),
      body: isHaveData
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                        flex: 2,
                        child: Container(
                          child: Column(
                            children: [
                              Icon(
                                Icons.person,
                                size: 40,
                              ),
                              Flexible(
                                child: GestureDetector(
                                  child: Text(
                                    _personellerDetails[0].perAdSoyad,
                                    style: TextStyle(
                                        backgroundColor: Colors.grey[200]),
                                  ),
                                  onTap: () {
                                    FlutterClipboard.copy(
                                        _personellerDetails[0].perAdSoyad);
                                    showFlushBarCopy(context: context);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ' TCKN : ',
                                    textAlign: TextAlign.center,
                                  ),
                                  Flexible(
                                    child: GestureDetector(
                                      child: Text(
                                        _personellerDetails[0].perTc,
                                        style: TextStyle(
                                            backgroundColor: Colors.grey[200]),
                                      ),
                                      onTap: () {
                                        FlutterClipboard.copy(
                                            _personellerDetails[0].perTc);
                                        showFlushBarCopy(context: context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                ' Görevi : ' + _personellerDetails[0].gorev,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                ' Birimi : ' + _personellerDetails[0].birim,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                ' Alt Birimi : ' +
                                    _personellerDetails[0].altbirim,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )),
                    Flexible(
                        flex: 3,
                        child: Container(
                          child: Column(
                            children: [
                              Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Flexible(
                                      child: ListTile(
                                        leading: Icon(Icons.school),
                                        title: Text(
                                          'Eğitim İşlemleri',
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EducationDetailScreen(
                                                        personelDetails:
                                                            _personellerDetails[
                                                                0],
                                                      )));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Flexible(
                                      child: ListTile(
                                        leading: Icon(MdiIcons.stethoscope),
                                        title: Text('Muayene İşlemleri'),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ExaminationDetailScreen(
                                                        personelDetails:
                                                            _personellerDetails[
                                                                0],
                                                      )));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Flexible(
                                      child: ListTile(
                                        leading: Icon(MdiIcons.needle),
                                        title: Text('Aşı İşlemleri'),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VaccineDetailScreen(
                                                        personelDetails:
                                                            _personellerDetails[
                                                                0],
                                                      )));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            ),
    );
  }
}