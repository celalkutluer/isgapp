import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

Flushbar showFlushBarCopy({BuildContext context}) {
  return Flushbar(
    message: "Kopyalandı",
    backgroundColor: Colors.blue.withOpacity(0.7),
    barBlur: 20,
    borderRadius: 16,
    flushbarPosition: FlushbarPosition.TOP,
    margin: EdgeInsets.fromLTRB(0, kToolbarHeight/2, 0, 0),
    duration: Duration(milliseconds: 600),
    padding: EdgeInsets.all(24),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    backgroundGradient: LinearGradient(
        colors: [Colors.blue, Colors.indigo.shade600],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter),
  )..show(context);
}
