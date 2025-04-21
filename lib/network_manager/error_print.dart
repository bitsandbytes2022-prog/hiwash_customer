import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonFunction {
  /// Show a normal toast (for success/info)
  static void toastMsg(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green.shade600,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// Show an alert/error toast
  static void alertToastMsg(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red.shade700,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
