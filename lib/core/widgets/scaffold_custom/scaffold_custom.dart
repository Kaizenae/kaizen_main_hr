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
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: isExtend!,
      resizeToAvoidBottomInset: true,
      appBar: appBarCustom,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
