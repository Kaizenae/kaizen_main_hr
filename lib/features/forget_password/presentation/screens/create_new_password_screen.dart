import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/widgets/component.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({
    super.key,
    required this.phoneNumber,
  });
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: AppStrings.createNewPassword,
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
                    keyboardType: TextInputType.visiblePassword,
                    suffix: true,
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

                      // width: 100,
                      onPressed: () async {
                        navigatorAndRemove(
                          context,
                          Routes.loginRoute,
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
      ),
    );
  }
}
