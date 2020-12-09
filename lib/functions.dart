import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:basic_utils/basic_utils.dart';

encodePass(String pass) {
  var bytes = utf8
      .encode(md5.convert(utf8.encode(pass)).toString()); // data being hashed
  var digest = sha256.convert(bytes); // Hashing Process
  return base64Encode(utf8.encode(digest.toString()));
}

timeEncode() {
  var zaman = DateTime.now().millisecondsSinceEpoch.toString();
  for (var i = 0; i < 3; i++) {
    zaman = base64Encode(utf8.encode(zaman));
    zaman = StringUtils.addCharAtPosition(zaman, "c", 3);
  }
  return zaman;
}

base64Decode(String value){
  return utf8.decode(base64.decode(value));
}