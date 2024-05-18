import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';
import '../cubit/register_cubit.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextCustom(
          fontSize: FontSize.s14,
          text: AppStrings.name,
          textAlign: TextAlign.start,
          color: ColorManager.white,
        ),
        const SizedBox(
          height: AppSize.s4,
        ),
        TextFormFieldCustom(
          controller: RegisterCubit.get(context).nameController,
          validate: (value) {
            if (value!.trim().isEmpty || value == ' ') {
              return AppStrings.nameTextField;
            }

            return null;
          },
          keyboardType: TextInputType.name,
          suffixIcon: IconsAssets.personIcon,
          suffix: true,
        ),
        const SizedBox(
          height: AppSize.s30,
        ),
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
          controller: RegisterCubit.get(context).emailController,
          validate: (value) {
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
          text: AppStrings.phone,
          textAlign: TextAlign.start,
          color: ColorManager.white,
        ),
        const SizedBox(
          height: AppSize.s4,
        ),
        TextFormFieldCustom(
          controller: RegisterCubit.get(context).phoneNumberController,
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

          // textInputAction: TextInputAction.done,
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
          controller: RegisterCubit.get(context).passwordController,
          validate: (v) {
            if (v!.isEmpty) {
              return AppStrings.passwordTextField;
            }
            return null;
          },
          keyboardType: TextInputType.visiblePassword,
          suffixIcon: RegisterCubit.get(context).suffix,
          suffix: true,
          obSecure: RegisterCubit.get(context).isPassword ? true : false,
          suffixOnPressed: () {
            RegisterCubit.get(context).changePasswordVisibility();
          },
          prefixOnPressed: () {
            RegisterCubit.get(context).changePasswordVisibility();
          },
        ),
        const SizedBox(
          height: AppSize.s30,
        ),
        TextCustom(
          fontSize: FontSize.s14,
          text: AppStrings.employeeCode,
          textAlign: TextAlign.start,
          color: ColorManager.white,
        ),
        const SizedBox(
          height: AppSize.s4,
        ),
        TextFormFieldCustom(
          controller: RegisterCubit.get(context).employeeCode,
          validate: (value) {
            if (value!.trim().isEmpty || value == ' ') {
              return AppStrings.nameTextField;
            }

            return null;
          },
          keyboardType: TextInputType.number,
          suffixIcon: IconsAssets.personIcon,
          suffix: true,
        ),
      ],
    );
  }
}
