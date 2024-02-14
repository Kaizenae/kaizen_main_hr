import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/color_manager.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final double? fontSize;

  final Color? color;

  final Color? decorationColor;

  final FontWeight? fontWeight;

  final TextDecoration decoration;

  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign textAlign;

  const TextCustom({
    super.key,
    required this.text,
    this.fontSize = 14.0,
    this.color = ColorManager.primary,
    this.decorationColor = ColorManager.primary,
    this.fontWeight = FontWeight.normal,
    this.decoration = TextDecoration.none,
    this.overflow,
    this.maxLines,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: fontSize?.sp,
              color: color,
              fontWeight: fontWeight,
              decoration: decoration,
              decorationColor: decorationColor,
            ));
  }
}
