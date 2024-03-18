import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/widgets/component.dart';
import 'package:Attendace/features/forget_password/presentation/controller/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';
import '../controller/states.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  CreateNewPasswordScreen({
    super.key,
    required this.phoneNumber,
    required this.userID,
  });
  final String phoneNumber;
  final int userID;
  final newPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: ScaffoldCustom(
        appBarCustom: const AppBarCustom(
          text: AppStrings.createNewPassword,
        ),
        body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
          listener: (context, state) {
            if (state is ChangePasswordSuccessState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.message),
                duration: Duration(
                  seconds: AppConstants.snackBarTime,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              navigatorAndRemove(
                context,
                Routes.loginRoute,
              );
            } else if (state is ChangePasswordErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.message),
                duration: Duration(
                  seconds: AppConstants.snackBarTime,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            return SafeArea(
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
                          text: AppStrings.newPassword,
                          textAlign: TextAlign.start,
                          color: ColorManager.textFormLabelColor,
                        ),
                        const SizedBox(
                          height: AppSize.s8,
                        ),
                        TextFormFieldCustom(
                          validate: (v) {
                            if (v!.isEmpty) {
                              return 'New Password must be not empty';
                            }
                            return null;
                          },
                          controller: newPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          suffix: true,
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
                                  onPressed: () {
                                    BlocProvider.of<ForgetPasswordCubit>(
                                            context)
                                        .changePassword(
                                      phoneNunber: phoneNumber,
                                      userId: userID.toString(),
                                      newPassword: newPasswordController.text,
                                    );
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
