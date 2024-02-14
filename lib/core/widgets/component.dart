import 'package:Attendace/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/font_manager.dart';
import '../utils/routes_manager.dart';

Future<bool?> showToast(
    {required String message, Color color = ColorManager.primary}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: FontSize.s16,
  );
}

void navigatorAndRemove(context, String screenName) {
  Navigator.pushAndRemoveUntil(
      context, Routes.createRoute(screenName), (Route<dynamic> route) => false);
}

void navigator(context, String screenName) {
  Navigator.of(context).push(Routes.createRoute(screenName));
}
