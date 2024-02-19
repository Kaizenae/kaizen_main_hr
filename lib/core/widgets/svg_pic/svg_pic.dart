// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/color_manager.dart';
import '../../utils/values_manager.dart';

class SvgPictureCustom extends StatelessWidget {
  final String assetsName;

  final double? height;

  final double? width;

  final Color? color;
  final BoxFit? boxFit;

  const SvgPictureCustom({
    super.key,
    required this.assetsName,
    this.height = AppSize.s20,
    this.width = AppSize.s20,
    this.color = ColorManager.black,
    this.boxFit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      fit: boxFit!,
      assetsName,
<<<<<<< HEAD
      height: height,
      width: width,
=======
      height: height!,
      width: width!,
>>>>>>> main
      color: color,
    );
  }
}
