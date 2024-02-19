import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:flutter_screenutil/flutter_screenutil.dart';
=======
>>>>>>> main
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
<<<<<<< HEAD
              showToast(
                message: "${state.loginEntity.resultEntity.message}",
                color: ColorManager.primary,
              );
              AppConstants.token = CacheHelper.get(key: AppStrings.token) ?? 0;
=======
              SnackBar snackBar = SnackBar(
                  content:
                      Text(state.loginEntity.resultEntity.message.toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              CacheHelper.put(
                  key: AppConstants.userId,
                  value: state.loginEntity.resultEntity.id.toString());

              AppConstants.token = CacheHelper.get(key: AppStrings.token) ?? 0;

>>>>>>> main
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
<<<<<<< HEAD
              showToast(message: state.message, color: Colors.red);
=======
              SnackBar snackBar =
                  SnackBar(content: Text(state.message.toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
>>>>>>> main
            }
          },
          builder: (context, state) {
            var loginCubit = LoginCubit.get(context);
            return Padding(
<<<<<<< HEAD
              padding: EdgeInsets.all(AppPadding.p20.r),
=======
              padding: const EdgeInsets.all(AppPadding.p20),
>>>>>>> main
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
<<<<<<< HEAD
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
=======
                          height: AppSize.s100,
                          width: AppSize.s100,
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      Center(
                        child: TextCustom(
                          color: ColorManager.primary,
                          text: AppStrings.welcomeBack,
                          fontSize: FontSize.s16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      TextCustom(
                        fontSize: FontSize.s14,
>>>>>>> main
                        text: AppStrings.email,
                        textAlign: TextAlign.start,
                        color: ColorManager.textFormLabelColor,
                      ),
<<<<<<< HEAD
                      SizedBox(
                        height: AppSize.s4.h,
=======
                      const SizedBox(
                        height: AppSize.s4,
>>>>>>> main
                      ),
                      TextFormFieldCustom(
                        controller: loginCubit.emailController,
                        validate: (value) {
                          if (value!.trim().isEmpty || value == ' ') {
                            return AppStrings.emailTextField;
                          }
<<<<<<< HEAD
                          if (!RegExp(
                                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(value)) {
                            return AppStrings.emailValidTextField;
                          }
=======
>>>>>>> main
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        suffixIcon: IconsAssets.emailIcon,
                        suffix: true,
                      ),
<<<<<<< HEAD
                      SizedBox(
                        height: AppSize.s30.h,
                      ),
                      const TextCustom(
=======
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      TextCustom(
                        fontSize: FontSize.s14,
>>>>>>> main
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
<<<<<<< HEAD
                        prefixOnPressed: () {
                          loginCubit.changePasswordVisibility();
                        },
=======
>>>>>>> main
                        suffixOnPressed: () {
                          loginCubit.changePasswordVisibility();
                        },
                      ),
<<<<<<< HEAD
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
=======
                      const SizedBox(
                        height: AppSize.s40,
                      ),
                      Center(
                        child: state is LoginLoadingState
                            ? const CupertinoActivityIndicator(
                                color: ColorManager.primary,
                                radius: AppSize.s16,
                              )
                            : ElevatedButtonCustom(
                                fontSize: FontSize.s14,
>>>>>>> main
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
<<<<<<< HEAD
=======
                      Center(
                        child: TextButton(
                          onPressed: () {
                            navigator(context, Routes.forgetPasswordRoute);
                          },
                          child: TextCustom(
                            color: ColorManager.primary,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w600,
                            text: AppStrings.forgetPassword,
                          ),
                        ),
                      ),
>>>>>>> main
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextCustom(
<<<<<<< HEAD
=======
                            fontSize: FontSize.s14,
>>>>>>> main
                            text: AppStrings.doNotHaveAccount,
                            color: ColorManager.grey,
                            fontWeight: FontWeight.w600,
                          ),
                          TextButton(
                            onPressed: () {
                              EndPoints.baseUrl;
<<<<<<< HEAD
                              navigatorAndRemove(context, Routes.registerRoute);
                            },
                            child: const TextCustom(
                                text: AppStrings.signup,
=======
                              navigator(context, Routes.registerRoute);
                            },
                            child: TextCustom(
                                fontSize: FontSize.s14,
                                text: AppStrings.signup,
                                color: ColorManager.primary,
>>>>>>> main
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
<<<<<<< HEAD
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
=======
                      // Center(
                      //   child: TextButton(
                      //     onPressed: () {
                      //       navigator(context, Routes.baseUrlRoute);
                      //     },
                      //     child: TextCustom(
                      //         color: ColorManager.primary,
                      //         fontSize: FontSize.s16,
                      //         fontWeight: FontWeight.w600,
                      //         text: AppStrings.baseUrl,
                      //         decoration: TextDecoration.underline),
                      //   ),
                      // ),
>>>>>>> main
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
