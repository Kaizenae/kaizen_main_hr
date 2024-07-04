// ignore_for_file: unused_element, unrelated_type_equality_checks

import 'dart:io';
import 'package:Attendace/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

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
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  String version = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => SplashBloc()..getVersion(),
        child: BlocConsumer<SplashBloc, SplashStates>(
          listener: (context, state) {
            if (state is GetVersionSuccessState) {
              version = state.version;
              _nextScreen();
            }
          },
          builder: (context, state) {
            version =
                SplashBloc.get(context).versionModel.result.version.toString();
            return const SizedBox(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1 / 3,
                  child: Image(
                    image: AssetImage(
                      ImageAssets.logoWhiteImg,
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
              onPressed: () async {
                if (Platform.isIOS) {
                  await launchInBrowser(Uri.parse(
                      "https://apps.apple.com/ae/app/kaizen-hr/id6504225336?platform=iphone"));
                } else if (Platform.isAndroid) {
                  await launchInBrowser(Uri.parse(
                      "https://play.google.com/store/apps/details?id=com.attendance.KAIZENHR"));
                }
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
                : Routes.homeRoute,
      );
    }
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
