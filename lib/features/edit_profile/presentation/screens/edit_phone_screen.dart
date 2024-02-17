// ignore_for_file: use_build_context_synchronously

import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

class EditPhoneScreen extends StatelessWidget {
  const EditPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: 'Update Phone',
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
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p20.w),
              child: Form(
                key: editProfileCubit.formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom(
                        text: 'Work Phone',
                        fontSize: FontSize.s14.sp,
                        textAlign: TextAlign.start,
                        color: ColorManager.textFormLabelColor,
                      ),
                      SizedBox(
                        height: AppSize.s8.h,
                      ),
                      TextFormFieldCustom(
                        controller: editProfileCubit.phoneNumberController,
                        validate: (value) {
                          if (value!.trim().isEmpty || value == ' ') {
                            return 'Department must be not Empty';
                          }

                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        suffixIcon: IconsAssets.phoneIcon,
                        suffix: true,
                      ),
                      SizedBox(
                        height: AppSize.s40.h,
                      ),
                      Center(
                        child: state is EditProfileLoadingState
                            ? CupertinoActivityIndicator(
                                color: ColorManager.primary,
                                radius: AppSize.s16.r,
                              )
                            : ElevatedButtonCustom(
                                fontSize: FontSize.s14.sp,

                                textColor: ColorManager.white,

                                // width: 100,
                                onPressed: () async {
                                  if (editProfileCubit.formKey.currentState!
                                      .validate()) {
                                    await editProfileCubit.editDepartmentFun();
                                    await BlocProvider.of<ProfileCubit>(context)
                                        .getEmployeeFun();
                                    editProfileCubit.formKey.currentState!
                                        .reset();
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
