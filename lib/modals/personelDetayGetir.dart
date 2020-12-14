import '../functions.dart';

class PersonelDetayGetirModel {
  String id;
  String perTc;
  String perAdSoyad;
  String birim;
  String altbirim;
  String gorev;
  String egitim;

  PersonelDetayGetirModel(
      {this.id,
        this.perTc,
        this.perAdSoyad,
        this.birim,
        this.altbirim,
        this.gorev,
        this.egitim});

  PersonelDetayGetirModel.fromJson(Map<String, dynamic> json) {
    id = base64Decode(json['id']);
    perTc = base64Decode(json['per_tc']);
    perAdSoyad = base64Decode(json['per_ad_soyad']);
    birim = base64Decode(json['birim']);
    altbirim = base64Decode(json['altbirim']);
    gorev = base64Decode(json['gorev']);
    egitim = base64Decode(json['egitim']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['per_tc'] = this.perTc;
    data['per_ad_soyad'] = this.perAdSoyad;
    data['birim'] = this.birim;
    data['altbirim'] = this.altbirim;
    data['gorev'] = this.gorev;
    data['egitim'] = this.egitim;
    return data;
  }
}