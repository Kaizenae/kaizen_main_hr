import 'package:Attendace/core/utils/color_manager.dart';
import 'package:Attendace/core/utils/values_manager.dart';
import 'package:flutter/cupertino.dart';

class ProgressIndicatorCustom extends StatelessWidget {
  const ProgressIndicatorCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s80,
      width: AppSize.s80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s10),
          color: CupertinoColors.secondaryLabel),
      child: const CupertinoActivityIndicator(
        color: ColorManager.white,
        radius: AppSize.s16,
      ),
    );
  }
}
