// ignore_for_file: unused_element, unrelated_type_equality_checks

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../core/api/end_points.dart';
import '../../core/utils/constants_manager.dart';
import '../../core/utils/routes_manager.dart';
import '../../core/utils/strings_manager.dart';
import '../../core/widgets/component.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            _getVideoBackground(),
          ],
        ),
      ),
    );
  }
}
