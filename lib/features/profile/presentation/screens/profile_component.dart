import 'package:Attendace/core/utils/routes_manager.dart';
import 'package:Attendace/features/myRequests/presentation/controller/myRequests_cubit.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class ProfileComponent extends StatelessWidget {
  final String iconName;
  final String name;
  final String screen;

  const ProfileComponent(
      {super.key,
      required this.name,
      required this.iconName,
      required this.screen});

  @override
  Widget build(BuildContext context) {
    return SlideInLeft(
      child: InkWell(
        onTap: () {
          if (screen == Routes.notificationsRoute) {
            MyRequestsCubit.get(context).userId = '';
            navigator(context, screen);
          } else {
            navigator(context, screen);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppPadding.p6.h),
          child: Row(
            children: [
              SvgPictureCustom(
                assetsName: iconName,
                color: ColorManager.primary,
              ),
              SizedBox(
                width: AppSize.s16.w,
              ),
              TextCustom(
                text: name,
                fontWeight: FontWeight.w200,
                fontSize: FontSize.s16.sp,
                color: ColorManager.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
