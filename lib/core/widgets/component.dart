import 'package:flutter/material.dart';

import '../utils/routes_manager.dart';

void navigatorAndRemove(context, String screenName) {
  Navigator.pushAndRemoveUntil(
      context, Routes.createRoute(screenName), (Route<dynamic> route) => false);
}

void navigator(context, String screenName) {
  Navigator.of(context).push(Routes.createRoute(screenName));
}
