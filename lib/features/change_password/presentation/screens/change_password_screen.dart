import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';
import '../../../../injection_container.dart';

import '../cubit/change_password_cubit.dart';
import '../cubit/change_password_state.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: 'Change Password',
      ),
      body: BlocProvider(
        create: (context) => sl<ChangePasswordCubit>(),
        child: BlocConsumer<ChangePasswordCubit, ChangePasswordStates>(
          listener: (context, state) {
            if (state is ChangePasswordSuccessState) {
              SnackBar snackBar = SnackBar(
                  content: Text(state
                      .changePasswordEntity.resultEntity.message[0]
                      .toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            } else if (state is ChangePasswordErrorState) {
              if (kDebugMode) {
                print(state.message);
              }
              SnackBar snackBar =
                  SnackBar(content: Text(state.message.toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            var changePasswordCubit = ChangePasswordCubit.get(context);
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: Form(
                  key: changePasswordCubit.formKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextCustom(
                          fontSize: FontSize.s14,
                          text: 'Old Password',
                          textAlign: TextAlign.start,
                          color: ColorManager.textFormLabelColor,
                        ),
                        const SizedBox(
                          height: AppSize.s8,
                        ),
                        TextFormFieldCustom(
                          controller: changePasswordCubit.oldPasswordController,
                          validate: (v) {
                            if (v!.isEmpty) {
                              return 'Old Password must be not empty';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          suffixIcon: changePasswordCubit.suffix,
                          suffix: true,
                          obSecure:
                              changePasswordCubit.isPassword ? true : false,
                          suffixOnPressed: () {
                            changePasswordCubit.changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s24,
                        ),
                        TextCustom(
                          fontSize: FontSize.s14,
                          text: 'New Password',
                          textAlign: TextAlign.start,
                          color: ColorManager.textFormLabelColor,
                        ),
                        const SizedBox(
                          height: AppSize.s8,
                        ),
                        TextFormFieldCustom(
                          controller: changePasswordCubit.newPasswordController,
                          validate: (v) {
                            if (v!.isEmpty) {
                              return 'New Password must be not empty';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          suffixIcon: changePasswordCubit.suffixConfirm,
                          suffix: true,
                          obSecure: changePasswordCubit.isPasswordConfirm
                              ? true
                              : false,
                          suffixOnPressed: () {
                            changePasswordCubit
                                .changePasswordConfirmVisibility();
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s40,
                        ),
                        Center(
                          child: state is ChangePasswordLoadingState
                              ? const CupertinoActivityIndicator(
                                  color: ColorManager.primary,
                                  radius: AppSize.s16,
                                )
                              : ElevatedButtonCustom(
                                  fontSize: FontSize.s14,

                                  textColor: ColorManager.white,

                                  // width: 100,
                                  onPressed: () async {
                                    if (changePasswordCubit
                                        .formKey.currentState!
                                        .validate()) {
                                      await changePasswordCubit
                                          .changePasswordFun();
                                      changePasswordCubit.formKey.currentState
                                          ?.reset();
                                    }
                                  },
                                  text: AppStrings.update,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
