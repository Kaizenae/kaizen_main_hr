import 'package:Attendace/core/utils/assets_manager.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/widgets/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: 'Forget Password',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p20.w),
          child: Form(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    fontSize: FontSize.s14.sp,
                    text: AppStrings.userName,
                    textAlign: TextAlign.start,
                    color: ColorManager.textFormLabelColor,
                  ),
                  SizedBox(
                    height: AppSize.s8.h,
                  ),
                  TextFormFieldCustom(
                    validate: (v) {
                      if (v!.isEmpty) {
                        return AppStrings.userNameValidation;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconsAssets.emailIcon,
                    suffix: true,
                  ),
                  SizedBox(
                    height: AppSize.s40.h,
                  ),
                  Center(
                    child:
                        //  state is ChangePasswordLoadingState
                        //     ? CupertinoActivityIndicator(
                        //         color: ColorManager.primary,
                        //         radius: AppSize.s16.r,
                        //       )
                        //     :
                        ElevatedButtonCustom(
                      fontSize: FontSize.s14.sp,
                      textColor: ColorManager.white,
                      onPressed: () {
                        navigator(
                          context,
                          Routes.otpScreenRoute,
                        );
                      },
                      text: AppStrings.submit,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
