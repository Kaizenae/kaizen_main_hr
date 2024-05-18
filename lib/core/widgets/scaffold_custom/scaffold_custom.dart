import 'package:Attendace/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

import '../app_bar/app_bar_custom.dart';

class ScaffoldCustom extends StatelessWidget {
  final Widget body;

  final String? appBarTitle;
  final IconData? icon;
  final Function? onPressed;
  final BottomNavigationBar? bottomNavigationBar;
  final AppBarCustom? appBarCustom;
  final bool? condition;

  final bool? isExtend;

  final Widget? floatingActionButton;
  final Key? scaffoldKey;
  final Color backgroundColor;

  const ScaffoldCustom({
    super.key,
    required this.body,
    this.scaffoldKey,
    this.appBarTitle,
    this.icon,
    this.onPressed,
    this.bottomNavigationBar,
    this.appBarCustom,
    this.condition = true,
    this.isExtend = false,
    this.floatingActionButton,
    this.backgroundColor = ColorManager.scaffoldColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      key: scaffoldKey,
      extendBodyBehindAppBar: isExtend!,
      resizeToAvoidBottomInset: true,
      appBar: appBarCustom,
      body: SafeArea(child: body),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
