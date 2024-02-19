import 'package:Attendace/core/utils/color_manager.dart';
import 'package:Attendace/core/utils/values_manager.dart';
import 'package:flutter/cupertino.dart';
<<<<<<< HEAD
import 'package:flutter_screenutil/flutter_screenutil.dart';
=======
>>>>>>> main

class ProgressIndicatorCustom extends StatelessWidget {
  const ProgressIndicatorCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
<<<<<<< HEAD
      height: AppSize.s80.h,
      width: AppSize.s80.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s10.r),
          color: CupertinoColors.secondaryLabel),
      child: CupertinoActivityIndicator(
        color: ColorManager.white,
        radius: AppSize.s16.r,
=======
      height: AppSize.s80,
      width: AppSize.s80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s10),
          color: CupertinoColors.secondaryLabel),
      child: const CupertinoActivityIndicator(
        color: ColorManager.white,
        radius: AppSize.s16,
>>>>>>> main
      ),
    );
  }
}
