import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../modals/personelGetirAnaSayfa.dart';
import '../../services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HomeScreenPersonelGetirModel> _personeller =
      List<HomeScreenPersonelGetirModel>();
  bool isHaveData = false;

  // void filterSearchResults(String query) {
  //   List<personelGetirAnaSayfaModal> dummySearchList = List<personelGetirAnaSayfaModal>();
  //
  //   dummySearchList.addAll(_personeller);
  //   if (query.isNotEmpty) {
  //     List<personelGetirAnaSayfaModal> dummyListData = List<personelGetirAnaSayfaModal>();
  //     dummySearchList.forEach((item) {
  //       if (item.contains(query.toUpperCase()) ||
  //           item.contains(query.toLowerCase())) {
  //         dummyListData.add(item);
  //       }
  //     });
  //     setState(() {
  //       items.clear();
  //       items.addAll(dummyListData);
  //     });
  //     return;
  //   } else {
  //     setState(() {
  //       items.clear();
  //       items.addAll(duplicateItems);
  //     });
  //   }
  // }

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
                          subtitle: Text('ADI VE SOYADI : '+_personeller[index].perAdSoyad),
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
