// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      padding: EdgeInsets.only(top: AppPadding.p4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconPath,
            height: AppSize.s20.h,
            color: ColorManager.secondary,
          ),
          SizedBox(
            width: AppSize.s8.w,
          ),
          SizedBox(
            width: AppSize.s4.w,
          ),
          TextCustom(
            text: subText,
            color: ColorManager.black,
          ),
          SizedBox(
            height: AppSize.s12.h,
          ),
        ],
      ),
    );
  }
}
