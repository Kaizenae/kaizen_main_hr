// ignore_for_file: unused_element, unrelated_type_equality_checks

import 'dart:async';
import 'package:Attendace/core/utils/assets_manager.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/api/end_points.dart';
import '../../core/utils/constants_manager.dart';
import '../../core/utils/routes_manager.dart';
import '../../core/utils/strings_manager.dart';
import '../../core/widgets/component.dart';
import 'controller/bloc.dart';
import 'controller/states.dart';

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

  String version = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => SplashBloc()..getVersion(),
        child: BlocBuilder<SplashBloc, SplashStates>(
          builder: (context, state) {
            version =
                SplashBloc.get(context).versionModel.result.version.toString();
            return SizedBox(
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
            );
          },
        ),
      ),
    );
  }

  void _nextScreen() {
    if (version != AppConstants.appVersion) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(
            AppStrings.youCannotUseTheApplication,
          ),
          content: const Text(
            AppStrings.pleaseUpdateThisApplication,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(AppStrings.ok),
            )
          ],
        ),
        barrierDismissible: false,
      );
    } else {
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
    }
  }
}
