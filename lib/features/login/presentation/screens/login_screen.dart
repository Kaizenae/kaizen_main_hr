import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        value: BlocProvider.of<LoginCubit>(context),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              SnackBar snackBar = SnackBar(
                content:
                    Text(state.loginEntity.resultEntity.message.toString()),
                duration: Duration(
                  seconds: AppConstants.snackBarTime,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              CacheHelper.put(
                  key: AppConstants.userId,
                  value: state.loginEntity.resultEntity.id.toString());

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
              SnackBar snackBar = SnackBar(
                content: Text(state.message.toString()),
                duration: Duration(
                  seconds: AppConstants.snackBarTime,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            var loginCubit = LoginCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: SingleChildScrollView(
                child: Form(
                  key: loginCubit.formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: AspectRatio(
                          aspectRatio: 3 / 1.2,
                          child: Image.asset(
                            ImageAssets.logoImg,
                            height: AppSize.s100,
                            width: AppSize.s100,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      Center(
                        child: TextCustom(
                          color: ColorManager.primary,
                          text: AppStrings.welcome,
                          fontSize: FontSize.s20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      TextCustom(
                        fontSize: FontSize.s14,
                        text: AppStrings.email,
                        textAlign: TextAlign.start,
                        color: ColorManager.primary,
                      ),
                      const SizedBox(
                        height: AppSize.s4,
                      ),
                      TextFormFieldCustom(
                        controller: loginCubit.emailController,
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
                        suffixOnPressed: () {
                          loginCubit.changePasswordVisibility();
                        },
                      ),
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
                                fontSize: FontSize.s16,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextCustom(
                            fontSize: FontSize.s14,
                            text: AppStrings.doNotHaveAccount,
                            color: ColorManager.grey,
                            fontWeight: FontWeight.w600,
                          ),
                          TextButton(
                            onPressed: () {
                              EndPoints.baseUrl;
                              navigator(context, Routes.registerRoute);
                            },
                            child: TextCustom(
                                fontSize: FontSize.s14,
                                text: AppStrings.signup,
                                color: ColorManager.primary,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
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
