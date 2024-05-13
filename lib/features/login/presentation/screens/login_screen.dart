import 'package:Attendace/features/login/presentation/screens/create_password.dart';
import 'package:Attendace/features/login/presentation/widgets/login_form_widget.dart';
import 'package:flutter/cupertino.dart';
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
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      body: BlocProvider.value(
        value: BlocProvider.of<LoginCubit>(context),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
<<<<<<< HEAD
              if (state.loginEntity.resultEntity.loginBefore == false) {
                SnackBar snackBar = SnackBar(
                  content:
                      Text(state.loginEntity.resultEntity.message.toString()),
                  duration: Duration(
                    seconds: AppConstants.snackBarTime,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreatePasswordAfterLoginScreen(
                            userID:
                                state.loginEntity.resultEntity.id.toString())));
              } else {
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
=======
              SnackBar snackBar = SnackBar(
                  content:
                      Text(state.loginEntity.resultEntity.message.toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              CacheHelper.put(
                  key: AppConstants.userId,
                  value: state.loginEntity.resultEntity.id.toString());
>>>>>>> 1cabfa8fd74b0e1257a8454ecd599f0984433f52

                AppConstants.token =
                    CacheHelper.get(key: AppStrings.token) ?? 0;

                AppConstants.admin =
                    CacheHelper.get(key: AppStrings.admin) ?? false;
                navigatorAndRemove(
                    context,
                    AppConstants.admin
                        ? Routes.mainRouteAdmin
                        : Routes.mainRoute);
              }
<<<<<<< HEAD
            } else if (state is LoginErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.message.toString()),
                duration: Duration(
                  seconds: AppConstants.snackBarTime,
                ),
              );
=======
              SnackBar snackBar =
                  SnackBar(content: Text(state.message.toString()));
>>>>>>> 1cabfa8fd74b0e1257a8454ecd599f0984433f52
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            var loginCubit = LoginCubit.get(context);
<<<<<<< HEAD
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: SingleChildScrollView(
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
                    LoginFormWidget(
                      formKey: formKey,
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
                                if (formKey.currentState!.validate()) {
                                  await loginCubit.loginFun();
                                  formKey.currentState!.reset();
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
                  ],
=======
            return Form(
              key: loginCubit.formKey,
              child: CustomScrollView(slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.1, 0.5, 0.7, 0.9],
                        colors: [
                          Color(0xff8845A9),
                          Color(0xff735DB3),
                          Color(0xff557FC2),
                          Color(0xff24B9DA),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: AspectRatio(
                              aspectRatio: 3 / 1.2,
                              child: Image.asset(
                                ImageAssets.logoImg,
                                height: AppSize.s80,
                                width: AppSize.s80,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
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
                            color: ColorManager.white,
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
                                    colors: const Color(0xff8845A9),
                                    textColor: ColorManager.white,
                                    borderColor: const Color(0xff8845A9),
                                    onPressed: () async {
                                      if (loginCubit.formKey.currentState!
                                          .validate()) {
                                        await loginCubit.loginFun();
                                        loginCubit.formKey.currentState!
                                            .reset();
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
                                color: ColorManager.white,
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
                                color: ColorManager.white,
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
                                  color: ColorManager.white,
                                  decoration: TextDecoration.underline,
                                  decorationColor: ColorManager.white,
                                ),
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
>>>>>>> 1cabfa8fd74b0e1257a8454ecd599f0984433f52
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
