import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';
import '../cubit/login_cubit.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextCustom(
          fontSize: FontSize.s14,
          text: AppStrings.email,
          textAlign: TextAlign.start,
          color: ColorManager.white,
        ),
        const SizedBox(
          height: AppSize.s4,
        ),
        TextFormFieldCustom(
          controller: LoginCubit.get(context).emailController,
          validate: (value) {
            if (value!.trim().isEmpty || value == ' ') {
              return AppStrings.emailTextField;
            }
            return null;
          },
          keyboardType: TextInputType.emailAddress,
          suffixIcon: IconsAssets.emailIcon,
          suffix: true,
        ),
        const SizedBox(
          height: AppSize.s30,
        ),
        TextCustom(
          fontSize: FontSize.s14,
          text: AppStrings.password,
          textAlign: TextAlign.start,
          color: ColorManager.white,
        ),
        const SizedBox(
          height: AppSize.s4,
        ),
        TextFormFieldCustom(
          controller: LoginCubit.get(context).passwordController,
          validate: (v) {
            if (v!.isEmpty) {
              return AppStrings.passwordTextField;
            }
            return null;
          },
          keyboardType: TextInputType.visiblePassword,
          suffixIcon: LoginCubit.get(context).suffix,
          suffix: true,
          obSecure: LoginCubit.get(context).isPassword ? true : false,
          suffixOnPressed: () {
            LoginCubit.get(context).changePasswordVisibility();
          },
        ),
        const SizedBox(
          height: AppSize.s40,
        ),
      ],
    );
  }
}
