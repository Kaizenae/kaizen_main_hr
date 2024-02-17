import 'package:Attendace/core/utils/values_manager.dart';
import 'package:Attendace/core/widgets/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  OtpFieldController otpController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: 'OTP',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextCustom(
              fontSize: FontSize.s14.sp,
              text: AppStrings.otpNumber,
              textAlign: TextAlign.start,
              color: ColorManager.textFormLabelColor,
            ),
            SizedBox(
              height: AppSize.s12.h,
            ),
            OTPTextField(
                controller: otpController,
                length: 6,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: AppSize.s50.w,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 12,
                style: Theme.of(context).textTheme.titleMedium!,
                onChanged: (pin) {},
                onCompleted: (pin) {}),
            SizedBox(
              height: AppSize.s40.h,
            ),
            ElevatedButtonCustom(
              fontSize: FontSize.s14.sp,
              textColor: ColorManager.white,
              onPressed: () {
                navigator(
                  context,
                  Routes.createNewPasswordRoute,
                );
              },
              text: AppStrings.submit,
            ),
          ],
        ),
      ),
    );
  }
}
