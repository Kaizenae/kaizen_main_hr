// ignore_for_file: deprecated_member_use

import 'package:Attendace/core/utils/color_manager.dart';
import 'package:Attendace/core/utils/font_manager.dart';
import 'package:flutter/material.dart';

class CustomHomeItem extends StatelessWidget {
  const CustomHomeItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final String icon;
  final String label;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: ColorManager.purple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image(
                    image: AssetImage(icon),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  label,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: FontSize.s16, color: ColorManager.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
