import 'package:flutter/material.dart';

import '../../utils/color_manager.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final double fontSize;

  final Color color;

  final Color decorationColor;

  final FontWeight fontWeight;

  final TextDecoration decoration;

  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign textAlign;

  const TextCustom({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    this.decorationColor = ColorManager.primary,
    this.fontWeight = FontWeight.normal,
    this.decoration = TextDecoration.none,
    this.overflow,
    this.maxLines,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(text,
          maxLines: maxLines,
          overflow: overflow,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: fontSize,
                color: color,
                fontWeight: fontWeight,
                decoration: decoration,
                decorationColor: decorationColor,
              )),
    );
  }
}
