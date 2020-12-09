import 'package:isgapp/functions.dart';

class personelGetirAnaSayfaModal {
  String perTc;
  String perAd;
  String perSoyad;

  personelGetirAnaSayfaModal({this.perTc, this.perAd, this.perSoyad});

  personelGetirAnaSayfaModal.fromJson(Map<String, dynamic> json) {
    perTc = base64Decode(json['per_tc']);
    perAd = base64Decode(json['per_ad']);
    perSoyad = base64Decode(json['per_soyad']);
  }

  Map<String, dynamic> toJson() {//gelen fieldları jsona dönüştürür
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['per_tc'] = this.perTc;
    data['per_ad'] = this.perAd;
    data['per_soyad'] = this.perSoyad;
    return data;
  }
}
