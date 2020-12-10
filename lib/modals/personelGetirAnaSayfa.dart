import 'package:isgapp/functions.dart';
import '../functions.dart';

class HomeScreenPersonelGetirModel {
  String id;
  String perTc;
  String perAdSoyad;

  HomeScreenPersonelGetirModel({this.id, this.perTc, this.perAdSoyad});

  HomeScreenPersonelGetirModel.fromJson(Map<String, dynamic> json) {
    id = base64Decode(json['id']);
    perTc = base64Decode(json['per_tc']);
    perAdSoyad = base64Decode(json['per_ad_soyad']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['per_tc'] = this.perTc;
    data['per_ad_soyad'] = this.perAdSoyad;
    return data;
  }
}
