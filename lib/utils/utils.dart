import 'package:alpha_ecommerce_18oct/utils/color.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static toastMessage(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  static showFlushBarWithMessage(
      String title, String msg, BuildContext context) {
    Flushbar(
      // title: title,
      forwardAnimationCurve: Curves.decelerate,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      padding: const EdgeInsets.all(12),
      backgroundColor: const Color.fromARGB(255, 23, 128, 128),
      messageColor: Colors.white,
      flushbarPosition: FlushbarPosition.TOP,
      reverseAnimationCurve: Curves.easeOutSine,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      positionOffset: 20,
      message: msg,
      duration: const Duration(seconds: 2),
    ).show(context);
  }
}
