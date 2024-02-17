import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/color_manager.dart';
import '../../utils/values_manager.dart';
import '../text_custom/text_custom.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final String? text;
  final Function? onPressed;
  final double? radius;
  final double? width;
  final double? elevation;
  final Color? colors;
  final Color? textColor;
  final double fontSize;
  final Widget? widget;
  final Color? borderColor;
  final FontWeight? fontWeight;

  const ElevatedButtonCustom({
    super.key,
    this.text,
    this.onPressed,
    this.radius = AppSize.s8,
    this.width = double.infinity,
    this.elevation = AppSize.s1_5,
    this.colors,
    required this.fontSize,
    this.textColor = ColorManager.white,
    this.widget,
    this.borderColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed!();
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
            side: BorderSide(color: borderColor ?? ColorManager.primary),
          ),
          backgroundColor: colors ?? ColorManager.primary,
          elevation: elevation,
          minimumSize: Size(width!.w, 55.h),

          // padding:
          //     EdgeInsets.symmetric(horizontal: width!.w, vertical: height!.h),
          textStyle: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: textColor)),
      child: widget ??
          TextCustom(
              color: textColor ?? ColorManager.primary,
              text: text!,
              fontSize: fontSize,
              textAlign: TextAlign.center),
    );
  }
}
