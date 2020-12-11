import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isgapp/pages/screens/personelDetailsScreen.dart';
import '../../modals/personelGetirAnaSayfa.dart';
import '../../services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController editingController = TextEditingController();

  List<HomeScreenPersonelGetirModel> _personellerSearchList =
      List<HomeScreenPersonelGetirModel>();
  List<HomeScreenPersonelGetirModel> _personellerAllList =
      List<HomeScreenPersonelGetirModel>();
  bool isHaveData = false;

  void filterSearchResults(String _query) {
    _query = _query.replaceAll('i',
        'İ'); //çetin gibi kelimelerde i harfini tanımamasından ötürü yazıldı.
    List<HomeScreenPersonelGetirModel> dummySearchList =
        List<HomeScreenPersonelGetirModel>();

    dummySearchList.addAll(_personellerAllList);

    if (_query.isNotEmpty) {
      List<HomeScreenPersonelGetirModel> _dummyListData =
          List<HomeScreenPersonelGetirModel>();
      dummySearchList.forEach((item) {
        if (item.perAdSoyad.contains(_query.toUpperCase()) ||
            item.perAdSoyad.contains(_query.toLowerCase())) {
          _dummyListData.add(item);
        }
      });
      setState(() {
        _personellerSearchList.clear();
        _personellerSearchList.addAll(_dummyListData);
      });
      return;
    } else {
      setState(() {
        _personellerSearchList.clear();
        _personellerSearchList.addAll(_personellerAllList);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPersonelGetirAnaSayfa().then((value) {
      setState(() {
        _personellerAllList.addAll(value);
        _personellerSearchList.addAll(_personellerAllList);
        isHaveData = true;
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
                      filterSearchResults(value);
                    },
                    controller: editingController,
                    decoration: InputDecoration(
                      labelText: "Ara",
                      hintText: "İsim Soyisim",
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        onPressed: () => editingController.clear(),
                        icon: Icon(Icons.clear),
                      ),
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
                    itemCount: _personellerSearchList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PersonelDetailScreen(
                                        personelDetails:
                                            _personellerSearchList[index])));
                          },
                          leading: Icon(Icons.person),
                          trailing: Icon(Icons.keyboard_arrow_right_sharp),
                          title: Text(
                              'TC NO : ' + _personellerSearchList[index].perTc),
                          subtitle: Text('ADI VE SOYADI : ' +
                              _personellerSearchList[index].perAdSoyad),
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
