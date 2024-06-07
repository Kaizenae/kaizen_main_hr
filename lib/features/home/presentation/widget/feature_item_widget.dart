import 'package:Attendace/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/color_manager.dart';

class FeatureItemWidget extends StatelessWidget {
  const FeatureItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final String title;
  final String icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 22, bottom: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            16,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.lightGrey.withOpacity(.5),
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
          color: ColorManager.white,
        ),
        child: Column(
          children: [
            Image(
              width: 24,
              height: 24,
              image: AssetImage(
                icon,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w600,
                    ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
