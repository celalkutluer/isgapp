import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertUtils {
  static Alert getErrorAlert(BuildContext context, String errorCode) {
    String title;
    String desc;

    switch (errorCode) {
      case "ERROR_INVALID_EMAIL":
        title = 'Yanlış email';
        desc = 'E-postanızı kontrol edip tekrar deneyin';
        break;
      case "ERROR_WRONG_PASSWORD":
        title = 'Yanlış şifre';
        desc = 'Şifrenizi kontrol edip tekrar deneyin';
        break;
      case "ERROR_USER_NOT_FOUND":
        title = 'Kullanıcı bulunamadı.';
        desc = 'Daha önce kaydolmuş olabilirsiniz. tekrar deneyin';
        break;
      case "ERROR_WEAK_PASSWORD":
        title = 'Zayıf Şifre';
        desc = 'En az 6 karakter içeren daha güçlü bir şifre kullanmayı deneyin';
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        title = 'Email zaten kullanılıyor';
        desc = 'Giriş yapmayı deneyin veya yeni bir hesap oluşturun';
        break;
      case "ERROR_GROUPNAME_IS_NULL":
        title = 'Geçersiz Grup adı';
        desc = 'Grup adı boş olamaz';
        break;
      case "ERROR_TAGLINE_IS_NULL":
        title = 'Geçersiz Grup Sloganı';
        desc = 'Grup sloganı boş olamaz';
        break;
      default:
        title = 'Error logging in';
        break;
    }
    return Alert(context: context, title: title, desc: desc);
  }
}