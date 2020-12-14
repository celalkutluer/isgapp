import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

Flushbar showFlushBarCopy({BuildContext context}) {
  return Flushbar(
    message: "Kopyalandı",
    backgroundColor: Colors.blue.withOpacity(0.7),
    barBlur: 20,
    borderRadius: 16,
    flushbarPosition: FlushbarPosition.TOP,
    margin: EdgeInsets.fromLTRB(8, kToolbarHeight/2+8, 8, 8),
    duration: Duration(milliseconds: 750),
    padding: EdgeInsets.all(24),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    backgroundGradient: LinearGradient(
        colors: [Colors.blue, Colors.indigo.shade600],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter),
  )..show(context);
}
