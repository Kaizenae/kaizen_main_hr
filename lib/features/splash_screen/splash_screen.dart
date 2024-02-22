// ignore_for_file: unused_element, unrelated_type_equality_checks

import 'dart:async';

import 'package:Attendace/core/utils/assets_manager.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../core/api/end_points.dart';
import '../../core/utils/constants_manager.dart';
import '../../core/utils/routes_manager.dart';
import '../../core/utils/strings_manager.dart';
import '../../core/widgets/component.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  void _startDelay() {
    _timer = Timer(
      const Duration(
        seconds: 5,
      ),
      _nextScreen,
    );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        child: FadeInUp(
          duration: const Duration(seconds: 3),
          child: const Center(
            child: AspectRatio(
              aspectRatio: 1 / 3,
              child: Image(
                image: AssetImage(
                  ImageAssets.logoImg,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _nextScreen() {
    navigatorAndRemove(
      context,
      EndPoints.baseUrl.isEmpty
          ? Routes.baseUrlRoute
          : AppConstants.token == AppStrings.empty || AppConstants.token == 0
              ? Routes.loginRoute
              : AppConstants.admin
                  ? Routes.mainRouteAdmin
                  : Routes.mainRoute,
    );

    // navigatorAndRemove(context, Routes.localAuthRoute);
  }
}
