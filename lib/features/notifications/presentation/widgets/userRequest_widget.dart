// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class UserRequestWidget extends StatelessWidget {
  final String iconPath;
  final String text;
  final String subText;
  const UserRequestWidget(
      {super.key,
      required this.iconPath,
      required this.text,
      required this.subText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconPath,
            height: AppSize.s20,
            color: ColorManager.secondary,
          ),
          const SizedBox(
            width: AppSize.s8,
          ),
          const SizedBox(
            width: AppSize.s4,
          ),
          TextCustom(
            fontSize: FontSize.s14,
            text: subText,
            color: ColorManager.black,
          ),
          const SizedBox(
            height: AppSize.s12,
          ),
        ],
      ),
    );
  }
}
