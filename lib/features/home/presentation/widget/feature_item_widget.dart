import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager.dart';

class FeatureItemWidget extends StatelessWidget {
  const FeatureItemWidget({
    super.key,
    required this.backgroundImg,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final String backgroundImg;
  final String title;
  final String icon;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(
              backgroundImg,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.white),
              ),
            ),
            Image(image: AssetImage(icon)),
          ],
        ),
      ),
    );
  }
}
