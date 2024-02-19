// ignore_for_file: file_names, deprecated_member_use

import 'package:Attendace/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_screenutil/flutter_screenutil.dart';
=======
>>>>>>> main
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/color_manager.dart';
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
<<<<<<< HEAD
            height: AppSize.s24.h,
            color: ColorManager.secondary,
          ),
          SizedBox(
            width: AppSize.s8.w,
=======
            height: AppSize.s24,
            color: ColorManager.secondary,
          ),
          const SizedBox(
            width: AppSize.s8,
>>>>>>> main
          ),
          // TextCustom(
          //   text: '$text :',
          //   color: ColorManager.black,
          //   fontSize: FontSize.s16,
          // ),
<<<<<<< HEAD
          SizedBox(
            width: AppSize.s4.w,
=======
          const SizedBox(
            width: AppSize.s4,
>>>>>>> main
          ),
          TextCustom(
            text: subText,
            color: ColorManager.black,
            fontSize: FontSize.s16,
          ),
<<<<<<< HEAD
          SizedBox(
            height: AppSize.s14.h,
=======
          const SizedBox(
            height: AppSize.s14,
>>>>>>> main
          ),
        ],
      ),
    );
  }
}
