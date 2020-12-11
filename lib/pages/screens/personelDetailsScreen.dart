import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import '../../widgets/flush_bar_widget.dart';
import '../../modals/personelGetirAnaSayfa.dart';

class PersonelDetailScreen extends StatefulWidget {
  final HomeScreenPersonelGetirModel personelDetails;

  PersonelDetailScreen({this.personelDetails});

  @override
  _PersonelDetailScreenState createState() => _PersonelDetailScreenState();
}

class _PersonelDetailScreenState extends State<PersonelDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personel Detay'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.person,
                size: 40,
              ),
              Text(
                widget.personelDetails.perAdSoyad,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(' TNKN : '),
                  GestureDetector(
                    child: Text(widget.personelDetails.perTc),
                    onTap: () {
                      FlutterClipboard.copy(widget.personelDetails.perTc);
                      showFlushBarCopy(context: context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
