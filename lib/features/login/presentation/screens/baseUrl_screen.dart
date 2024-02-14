// ignore_for_file: file_names, use_build_context_synchronously

import 'package:Attendace/core/api/end_points.dart';
import 'package:Attendace/core/widgets/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class BaseUrlScreen extends StatelessWidget {
  const BaseUrlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(isNull: false),
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var loginCubit = LoginCubit.get(context);
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Form(
                key: loginCubit.baseKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          ImageAssets.logoImg,
                          height: AppSize.s100,
                          width: AppSize.s100,
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      Center(
                        child: TextCustom(
                          text: AppStrings.welcomeBack,
                          fontSize: FontSize.s32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      const TextCustom(
                        text: AppStrings.baseUrl,
                        textAlign: TextAlign.start,
                        color: ColorManager.textFormLabelColor,
                      ),
                      const SizedBox(
                        height: AppSize.s4,
                      ),
                      TextFormFieldCustom(
                        controller: loginCubit.baseUrlController,
                        validate: (value) {
                          if (value!.trim().isEmpty || value == ' ') {
                            return AppStrings.baseUrlTextField;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.url,
                        suffixIcon: IconsAssets.locationIcon,
                        suffix: true,
                      ),
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      const SizedBox(
                        height: AppSize.s40,
                      ),
                      Center(
                        child: state is CacheUrlStateLoading
                            ? CupertinoActivityIndicator(
                                color: ColorManager.primary,
                                radius: AppSize.s16.r,
                              )
                            : ElevatedButtonCustom(
                                textColor: ColorManager.white,
                                onPressed: () async {
                                  if (loginCubit.baseKey.currentState!
                                      .validate()) {
                                    await loginCubit.cacheBaseUrl();
                                    if (EndPoints.baseUrl == '') {
                                    } else {
                                      navigatorAndRemove(
                                          context, Routes.loginRoute);
                                    }

                                    // Restart.restartApp(
                                    //     webOrigin: AppConstants.admin
                                    //         ? Routes.mainRouteAdmin
                                    //         : Routes.mainRoute);
                                  }
                                },
                                text: AppStrings.save,
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
