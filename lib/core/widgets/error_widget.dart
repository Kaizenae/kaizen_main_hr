import 'package:Attendace/core/utils/media_query_values.dart';
import 'package:Attendace/core/utils/values_manager.dart';
import 'package:Attendace/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:Attendace/core/widgets/text_custom/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_manager.dart';
import '../utils/font_manager.dart';

class ErrorsWidget extends StatelessWidget {
  final VoidCallback? onPress;

  const ErrorsWidget({super.key, this.onPress});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.warning_amber_rounded,
              color: ColorManager.primary,
              size: 100.w,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.h),
            child: TextCustom(
                text: 'Something Went Wrong',
                color: Colors.black,
                fontSize: FontSize.s16.sp,
                fontWeight: FontWeight.w700),
          ),
          TextCustom(
              text: 'Try again',
              color: ColorManager.grey1,
              fontSize: FontSize.s14.sp,
              fontWeight: FontWeight.w500),
          Container(
            height: AppSize.s50.h,
            width: context.width * 0.55,
            margin: EdgeInsets.symmetric(vertical: 15.h),
            child: ElevatedButtonCustom(
              text: 'Reload Screen',
              onPressed: () {
                if (onPress != null) {
                  onPress!();
                }
              },
              fontSize: FontSize.s14.sp,
            ),
          )
        ],
      ),
    );
  }
}
