import 'package:Attendace/core/utils/assets_manager.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/features/forget_password/presentation/screens/otp_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: 'Forget Password',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Form(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    fontSize: FontSize.s14,
                    text: AppStrings.phone,
                    textAlign: TextAlign.start,
                    color: ColorManager.textFormLabelColor,
                  ),
                  const SizedBox(
                    height: AppSize.s8,
                  ),
                  TextFormFieldCustom(
                    validate: (value) {
                      if (value!.trim().isEmpty || value == ' ') {
                        return AppStrings.phoneTextField;
                      }
                      return null;
                    },
                    prefix: true, isRegister: true,
                    hint: "5x xxx xxxx",
                    keyboardType: TextInputType.phone,
                    suffixIcon: IconsAssets.phoneIcon,
                    suffix: true,
                    controller: phoneNumberController,
                    // textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(
                    height: AppSize.s40,
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
                      fontSize: FontSize.s14,
                      textColor: ColorManager.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OTPScreen(
                              phoneNumber: phoneNumberController.text,
                            ),
                          ),
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
