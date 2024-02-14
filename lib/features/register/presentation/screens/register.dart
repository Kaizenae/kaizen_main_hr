import 'package:Attendace/core/utils/media_query_values.dart';
import 'package:Attendace/features/companies/presentation/cubit/companies_cubit.dart';
import 'package:Attendace/features/companies/presentation/cubit/companies_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      body: BlocProvider.value(
        value: BlocProvider.of<RegisterCubit>(context)..getUniqueDeviceId(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              showToast(
                message: "${state.registerEntity.resultEntity.message}",
                color: ColorManager.primary,
              );
              navigatorAndRemove(context, Routes.loginRoute);
              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()) ,(route) => false,);
            } else if (state is RegisterErrorState) {
              showToast(message: state.message, color: Colors.red);
            }
          },
          builder: (context, state) {
            var registerCubit = RegisterCubit.get(context);
            return Padding(
              padding: EdgeInsets.all(AppPadding.p16.r),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: registerCubit.formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          ImageAssets.logoImg,
                          height: AppSize.s100.w,
                          width: AppSize.s100.w,
                        ),
                      ),
                      // SizedBox(
                      //   height: AppSize.s20.h,
                      // ),
                      // Center(
                      //   child: TextCustom(
                      //     text: AppStrings.welcome,
                      //     fontSize: FontSize.s32.sp,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: AppSize.s30.h,
                      // ),
                      // const TextCustom(
                      //   text: AppStrings.baseUrl,
                      //   textAlign: TextAlign.start,
                      //   color: ColorManager.textFormLabelColor,
                      // ),
                      // SizedBox(
                      //   height: AppSize.s4.h,
                      // ),
                      // Center(
                      //   child: Container(
                      //     height: AppSize.s50.h,
                      //     width: context.width / 1.1,
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
                        text: AppStrings.company,
                        textAlign: TextAlign.start,
                        color: ColorManager.textFormLabelColor,
                      ),
                      SizedBox(
                        height: AppSize.s4.h,
                      ),
                      Material(
                        child: DropdownButtonHideUnderline(
                          child: BlocProvider.value(
                            value: BlocProvider.of<CompaniesCubit>(context)
                              ..getCompaniesFun(),
                            child: BlocConsumer<CompaniesCubit, CompaniesState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return state is GetCompaniesSuccess
                                    ? Container(
                                        decoration: BoxDecoration(
                                            color: ColorManager.textFormColor,
                                            borderRadius: BorderRadius.circular(
                                                AppSize.s8.r)),
                                        width: context.width / 1.1,
                                        height: AppSize.s50.h,
                                        child: InkWell(
                                          onTap: () {
                                            showCupertinoModalPopup<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    height: AppSize.s100.h * 3,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 6.0),
                                                    color:
                                                        CupertinoColors.white,
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              DefaultTextStyle(
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  CupertinoColors
                                                                      .black,
                                                              fontSize: 22.0,
                                                            ),
                                                            child:
                                                                GestureDetector(
                                                              // Blocks taps from propagating to the modal sheet and popping.
                                                              onTap: () {},
                                                              child: SafeArea(
                                                                top: false,
                                                                child:
                                                                    CupertinoPicker(
                                                                  magnification:
                                                                      1.5,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  itemExtent:
                                                                      30,
                                                                  //height of each item
                                                                  looping:
                                                                      false,

                                                                  children: List.generate(
                                                                      state
                                                                          .companiesEntity
                                                                          .resultEntity
                                                                          .response
                                                                          .length,
                                                                      (index) => TextCustom(
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          text: state
                                                                              .companiesEntity
                                                                              .resultEntity
                                                                              .response[index]
                                                                              .name)),
                                                                  onSelectedItemChanged:
                                                                      (index) {
                                                                    registerCubit.companyId = state
                                                                        .companiesEntity
                                                                        .resultEntity
                                                                        .response[
                                                                            index]
                                                                        .id;
                                                                    registerCubit.companyName = state
                                                                        .companiesEntity
                                                                        .resultEntity
                                                                        .response[
                                                                            index]
                                                                        .name;
                                                                    // setState(() {
                                                                    //   selectItem=value.toString();
                                                                    // });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        ElevatedButtonCustom(
                                                          text: 'Done',
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: TextCustom(
                                            text: registerCubit
                                                    .companyName.isEmpty
                                                ? 'Select The Company'
                                                : registerCubit.companyName,
                                          ),
                                        ),
                                      )
                                    : state is GetCompaniesError
                                        ? const SizedBox()
                                        : ShimmerCustom(
                                            child: SizedBox(
                                            height: AppSize.s50.h,
                                            child: DropdownMenu(
                                                width: context.width / 1.1,
                                                hintText: 'Select the company',
                                                key: const Key('2'),
                                                inputDecorationTheme:
                                                    InputDecorationTheme(
                                                  filled: true,
                                                  fillColor: ColorManager
                                                      .textFormColor,
                                                  isDense: true,
                                                  //floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSize.s8.r),
                                                    borderSide: BorderSide(
                                                      color: ColorManager
                                                          .textFormColor,
                                                      width: AppSize.s1_5.w,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSize.s8.r),
                                                    borderSide: BorderSide(
                                                      color: ColorManager
                                                          .textFormColor,
                                                      width: AppSize.s1_5.w,
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                    vertical: AppPadding.p8.h,
                                                    horizontal:
                                                        AppPadding.p16.w,
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSize.s8.r),
                                                    borderSide: BorderSide(
                                                      color: ColorManager
                                                          .textFormColor,
                                                      width: AppSize.s1_5.w,
                                                    ),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSize.s8.r),
                                                    borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: AppSize.s1_5.w,
                                                    ),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSize.s8.r),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  suffixIconColor: ColorManager
                                                      .textFormIconColor,
                                                  focusColor: ColorManager
                                                      .textFormColor,
                                                ),
                                                enabled: false,
                                                trailingIcon: const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: ColorManager.primary,
                                                ),
                                                dropdownMenuEntries: const []),
                                          ));
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s30.h,
                      ),
                      const TextCustom(
                        text: AppStrings.name,
                        textAlign: TextAlign.start,
                        color: ColorManager.textFormLabelColor,
                      ),
                      SizedBox(
                        height: AppSize.s4.h,
                      ),
                      TextFormFieldCustom(
                        controller: registerCubit.nameController,
                        validate: (value) {
                          if (value!.trim().isEmpty || value == ' ') {
                            return AppStrings.nameTextField;
                          }

                          return null;
                        },
                        keyboardType: TextInputType.name,
                        suffixIcon: IconsAssets.personIcon,
                        suffix: true,
                      ),
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
                        controller: registerCubit.emailController,
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
                        text: AppStrings.phone,
                        textAlign: TextAlign.start,
                        color: ColorManager.textFormLabelColor,
                      ),
                      SizedBox(
                        height: AppSize.s4.h,
                      ),

                      TextFormFieldCustom(
                        controller: registerCubit.phoneNumberController,
                        validate: (value) {
                          if (value!.trim().isEmpty || value == ' ') {
                            return AppStrings.phoneTextField;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        suffixIcon: IconsAssets.phoneIcon,
                        suffix: true,

                        // textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: AppSize.s30.h,
                      ),
                      const TextCustom(
                        text: AppStrings.password,
                        textAlign: TextAlign.start,
                        color: ColorManager.textFormLabelColor,
                      ),
                      SizedBox(
                        height: AppSize.s4.h,
                      ),
                      TextFormFieldCustom(
                        controller: registerCubit.passwordController,
                        validate: (v) {
                          if (v!.isEmpty) {
                            return AppStrings.passwordTextField;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: registerCubit.suffix,
                        suffix: true,
                        obSecure: registerCubit.isPassword ? true : false,
                        suffixOnPressed: () {
                          registerCubit.changePasswordVisibility();
                        },
                        prefixOnPressed: () {
                          registerCubit.changePasswordVisibility();
                        },
                      ),
                      SizedBox(
                        height: AppSize.s40.h,
                      ),
                      Center(
                        child: state is RegisterLoadingState
                            ? CupertinoActivityIndicator(
                                color: ColorManager.primary,
                                radius: AppSize.s16.r,
                              )
                            : ElevatedButtonCustom(
                                textColor: ColorManager.white,
                                onPressed: () async {
                                  await registerCubit.getUniqueDeviceId();

                                  if (registerCubit.formKey.currentState!
                                      .validate()) {
                                    await registerCubit.registerFun();
                                    registerCubit.formKey.currentState!.reset();
                                  }
                                },
                                text: AppStrings.register,
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextCustom(
                            text: AppStrings.haveAccount,
                            color: ColorManager.grey,
                            fontWeight: FontWeight.w600,
                          ),
                          TextButton(
                            onPressed: () {
                              navigatorAndRemove(context, Routes.loginRoute);
                            },
                            child: const TextCustom(
                                text: AppStrings.login,
                                decoration: TextDecoration.underline),
                          ),
                          SizedBox(
                            height: AppSize.s40.h,
                          ),
                        ],
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
