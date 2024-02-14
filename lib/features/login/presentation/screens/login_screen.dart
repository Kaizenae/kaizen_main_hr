import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      body: BlocProvider.value(
        value: BlocProvider.of<LoginCubit>(context)..getUniqueDeviceId(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              showToast(
                message: "${state.loginEntity.resultEntity.message}",
                color: ColorManager.primary,
              );
              AppConstants.token = CacheHelper.get(key: AppStrings.token) ?? 0;
              AppConstants.admin =
                  CacheHelper.get(key: AppStrings.admin) ?? false;
              navigatorAndRemove(
                  context,
                  AppConstants.admin
                      ? Routes.mainRouteAdmin
                      : Routes.mainRoute);
            } else if (state is LoginErrorState) {
              if (kDebugMode) {
                print(state.message);
              }
              showToast(message: state.message, color: Colors.red);
            }
          },
          builder: (context, state) {
            var loginCubit = LoginCubit.get(context);
            return Padding(
              padding: EdgeInsets.all(AppPadding.p16.r),
              child: SingleChildScrollView(
                child: Form(
                  key: loginCubit.formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          ImageAssets.logoImg,
                          height: AppSize.s100.h,
                          width: AppSize.s100.h,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s20.h,
                      ),
                      Center(
                        child: TextCustom(
                          text: AppStrings.welcomeBack,
                          fontSize: FontSize.s32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //  SizedBox(
                      //   height: AppSize.s30.h,
                      // ),
                      // const TextCustom(
                      //   text: AppStrings.baseUrl,
                      //   textAlign: TextAlign.start,
                      //   color: ColorManager.textFormLabelColor,
                      // ),
                      //  SizedBox(
                      //   height: AppSize.s4.h,
                      // ),
                      // Center(
                      //   child: Container(
                      //     height: AppSize.s50.h,
                      //     width: context.width/1.1,
                      //     padding: EdgeInsets.all(AppPadding.p8.r),
                      //     decoration: BoxDecoration(
                      //       color: ColorManager.textFormColor,
                      //       borderRadius: BorderRadius.circular(AppSize.s8.r),
                      //     ),
                      //     child: TextCustom(
                      //       text: EndPoints.baseUrl,
                      //       color: ColorManager.textFormLabelColor,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: AppSize.s30.h,
                      ),
                      const TextCustom(
                        text: AppStrings.email,
                        textAlign: TextAlign.start,
                        color: ColorManager.textFormLabelColor,
                      ),
                      SizedBox(
                        height: AppSize.s4.h,
                      ),
                      TextFormFieldCustom(
                        controller: loginCubit.emailController,
                        validate: (value) {
                          if (value!.trim().isEmpty || value == ' ') {
                            return AppStrings.emailTextField;
                          }
                          if (!RegExp(
                                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(value)) {
                            return AppStrings.emailValidTextField;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        suffixIcon: IconsAssets.emailIcon,
                        suffix: true,
                      ),
                      SizedBox(
                        height: AppSize.s30.h,
                      ),
                      const TextCustom(
                        text: AppStrings.password,
                        textAlign: TextAlign.start,
                        color: ColorManager.textFormLabelColor,
                      ),
                      const SizedBox(
                        height: AppSize.s4,
                      ),
                      TextFormFieldCustom(
                        controller: loginCubit.passwordController,
                        validate: (v) {
                          if (v!.isEmpty) {
                            return AppStrings.passwordTextField;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: loginCubit.suffix,
                        suffix: true,
                        obSecure: loginCubit.isPassword ? true : false,
                        prefixOnPressed: () {
                          loginCubit.changePasswordVisibility();
                        },
                        suffixOnPressed: () {
                          loginCubit.changePasswordVisibility();
                        },
                      ),
                      SizedBox(
                        height: AppSize.s40.h,
                      ),
                      Center(
                        child: state is LoginLoadingState
                            ? CupertinoActivityIndicator(
                                color: ColorManager.primary,
                                radius: AppSize.s16.r,
                              )
                            : ElevatedButtonCustom(
                                textColor: ColorManager.white,
                                onPressed: () async {
                                  if (loginCubit.formKey.currentState!
                                      .validate()) {
                                    await loginCubit.loginFun();
                                    loginCubit.formKey.currentState!.reset();
                                  }
                                },
                                text: AppStrings.login,
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextCustom(
                            text: AppStrings.doNotHaveAccount,
                            color: ColorManager.grey,
                            fontWeight: FontWeight.w600,
                          ),
                          TextButton(
                            onPressed: () {
                              EndPoints.baseUrl;
                              navigatorAndRemove(context, Routes.registerRoute);
                            },
                            child: const TextCustom(
                                text: AppStrings.signup,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            navigator(context, Routes.baseUrlRoute);
                          },
                          child: TextCustom(
                              fontSize: FontSize.s16,
                              fontWeight: FontWeight.w600,
                              text: AppStrings.baseUrl,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
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
