// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'package:Attendace/core/utils/values_manager.dart';
import 'package:Attendace/core/widgets/component.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
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
  late Timer timer;
  int start = 59;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: 'OTP',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextCustom(
              fontSize: FontSize.s14,
              text: AppStrings.otpNumber,
              textAlign: TextAlign.start,
              color: ColorManager.textFormLabelColor,
            ),
            const SizedBox(
              height: AppSize.s12,
            ),
            OTPTextField(
                controller: otpController,
                length: 6,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: AppSize.s50,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 12,
                style: Theme.of(context).textTheme.titleMedium!,
                onChanged: (pin) {},
                onCompleted: (pin) {}),
            const SizedBox(
              height: AppSize.s20,
            ),
            start != 0
                ? TextCustom(
                    fontSize: FontSize.s14,
                    text: "The code will expire after 00:$start",
                    textAlign: TextAlign.start,
                    color: ColorManager.darkGrey,
                  )
                : Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: GestureDetector(
                      onTap: () {
                        start = 59;
                        startTimer();
                        setState(() {});
                      },
                      child: TextCustom(
                        fontSize: FontSize.s14,
                        text: AppStrings.resendCode,
                        textAlign: TextAlign.start,
                        color: ColorManager.textFormLabelColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
            const SizedBox(
              height: AppSize.s20,
            ),
            ElevatedButtonCustom(
              fontSize: FontSize.s14,
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

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
