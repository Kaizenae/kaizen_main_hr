import 'package:flutter/material.dart';

import '../../utils/color_manager.dart';
import '../../utils/font_manager.dart';
import '../../utils/values_manager.dart';
import '../text_custom/text_custom.dart';

class ShiftAllocationItem extends StatelessWidget {
  const ShiftAllocationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextCustom(
            fontSize: FontSize.s14,
            text: "14/02",
            color: ColorManager.black,
          ),
          TextCustom(
            fontSize: FontSize.s14,
            text: "16/02",
            color: ColorManager.primary,
          ),
          TextCustom(
            fontSize: FontSize.s14,
            text: "IDC-M 9-12",
            color: ColorManager.error,
          ),
          TextCustom(
            fontSize: FontSize.s14,
            text: "DRAFT",
            color: ColorManager.secondary,
          ),
        ],
      ),
    );
  }
}
