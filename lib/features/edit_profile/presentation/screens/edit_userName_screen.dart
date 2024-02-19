// ignore_for_file: file_names, use_build_context_synchronously

import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/utils/assets_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';

import '../../../profile/presentation/cubit/profile_cubit.dart';
import '../cubit/edit_profile_cubit.dart';
import '../cubit/edit_profile_state.dart';

class EditUserNameScreen extends StatelessWidget {
  const EditUserNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: 'Update Name',
      ),
      body: BlocConsumer<EditProfileCubit, EditProfileStates>(
        listener: (context, state) {
          if (state is EditProfileSuccessState) {
            SnackBar snackBar = SnackBar(
                content: Text(
                    state.editProfileEntity.resultEntity.message.toString()));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            AppConstants.admin
                ? navigatorAndRemove(context, Routes.mainRouteAdmin)
                : navigatorAndRemove(context, Routes.mainRoute);
          } else if (state is EditProfileErrorState) {
            if (kDebugMode) {
              print(state.message);
            }
            SnackBar snackBar =
                SnackBar(content: Text(state.message.toString()));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          var editProfileCubit = EditProfileCubit.get(context);
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Form(
                key: editProfileCubit.formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom(
                        fontSize: FontSize.s14,
                        text: 'UserName',
                        textAlign: TextAlign.start,
                        color: ColorManager.textFormLabelColor,
                      ),
                      const SizedBox(
                        height: AppSize.s8,
                      ),
                      TextFormFieldCustom(
                        controller: editProfileCubit.userNameController,
                        validate: (value) {
                          if (value!.trim().isEmpty || value == ' ') {
                            return 'UserName must be not Empty';
                          }

                          return null;
                        },
                        keyboardType: TextInputType.name,
                        suffixIcon: IconsAssets.personIcon,
                        suffix: true,
                      ),
                      const SizedBox(
                        height: AppSize.s40,
                      ),
                      Center(
                        child: state is EditProfileLoadingState
                            ? const CupertinoActivityIndicator(
                                color: ColorManager.primary,
                                radius: AppSize.s16,
                              )
                            : ElevatedButtonCustom(
                                fontSize: FontSize.s14,

                                textColor: ColorManager.white,

                                // width: 100,
                                onPressed: () async {
                                  if (editProfileCubit.formKey.currentState!
                                      .validate()) {
                                    await editProfileCubit.editUserNameFun();
                                    await BlocProvider.of<ProfileCubit>(context)
                                        .getEmployeeFun();

                                    editProfileCubit.formKey.currentState
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
    );
  }
}
