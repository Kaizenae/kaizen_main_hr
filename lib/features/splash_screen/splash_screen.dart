// ignore_for_file: unused_element, unrelated_type_equality_checks

import 'dart:async';
<<<<<<< HEAD
import 'package:Attendace/core/utils/assets_manager.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
=======

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
>>>>>>> 1cabfa8fd74b0e1257a8454ecd599f0984433f52

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
  VideoPlayerController? _controller;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _controller = VideoPlayerController.asset("assets/images/splash.mp4");
    _controller!.initialize().then((_) {
      _controller!.setLooping(true);
      Timer(const Duration(milliseconds: 100), () {
        setState(() {
          _controller!.play();
          _visible = true;
        });
      });
    });

    Future.delayed(const Duration(seconds: 4), () {
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
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller?.dispose();
      _controller = null;
    }
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      child: VideoPlayer(_controller!),
    );
  }

  _getBackgroundColor() {
    return Container(color: Colors.transparent //.withAlpha(120),
        );
  }

  _getContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }

  String version = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
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
=======
      body: Center(
        child: Stack(
          children: <Widget>[
            _getVideoBackground(),
          ],
>>>>>>> 1cabfa8fd74b0e1257a8454ecd599f0984433f52
        ),
      ),
    );
  }
<<<<<<< HEAD

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
=======
>>>>>>> 1cabfa8fd74b0e1257a8454ecd599f0984433f52
}
