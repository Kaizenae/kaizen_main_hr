import 'package:Attendace/core/utils/font_manager.dart';
import 'package:Attendace/core/utils/media_query_values.dart';
import 'package:Attendace/features/register/domain/usecases/register_usecase.dart';
import 'package:Attendace/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
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
      body: BlocProvider(
        create: (context) =>
            RegisterCubit(registerUsecase: sl<RegisterUsecase>())
              ..getCompaniesData(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              SnackBar snackBar = SnackBar(
                content:
                    Text(state.registerEntity.resultEntity.message.toString()),
                duration: Duration(
                  seconds: AppConstants.snackBarTime,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              navigatorAndRemove(context, Routes.loginRoute);
              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()) ,(route) => false,);
            } else if (state is RegisterErrorState) {
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
            var registerCubit = RegisterCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: registerCubit.formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: AspectRatio(
                          aspectRatio: 3 / 1.2,
                          child: Image.asset(
                            ImageAssets.logoImg,
                            // height: AppSize.s150,
                            // width: AppSize.s120,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSize.s30),
                      TextCustom(
                        fontSize: FontSize.s14,
                        text: AppStrings.company,
                        textAlign: TextAlign.start,
                        color: ColorManager.textFormLabelColor,
                      ),
                      const SizedBox(
                        height: AppSize.s4,
                      ),
                      Material(
                        child: DropdownButtonHideUnderline(
                          child: registerCubit.companiesDataModel.result
                                  .responseModel.isNotEmpty
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: ColorManager.textFormColor,
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s8)),
                                  width: context.width / 1.1,
                                  height: AppSize.s50,
                                  child: InkWell(
                                    onTap: () {
                                      showCupertinoModalPopup<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: AppSize.s100 * 3,
                                              padding: const EdgeInsets.only(
                                                  top: 6.0),
                                              color: CupertinoColors.white,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: DefaultTextStyle(
                                                      style: const TextStyle(
                                                        color: CupertinoColors
                                                            .black,
                                                        fontSize: 18.0,
                                                      ),
                                                      child: GestureDetector(
                                                        // Blocks taps from propagating to the modal sheet and popping.
                                                        onTap: () {},
                                                        child: SafeArea(
                                                          top: false,
                                                          child:
                                                              CupertinoPicker(
                                                            magnification: 1.5,
                                                            backgroundColor:
                                                                Colors.white,
                                                            itemExtent: 30,
                                                            //height of each item
                                                            looping: false,

                                                            children:
                                                                List.generate(
                                                              registerCubit
                                                                  .companiesDataModel
                                                                  .result
                                                                  .responseModel
                                                                  .length,
                                                              (index) =>
                                                                  Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                  8.0,
                                                                ),
                                                                child:
                                                                    FittedBox(
                                                                  fit: BoxFit
                                                                      .scaleDown,
                                                                  child: TextCustom(
                                                                      color: ColorManager
                                                                          .primary,
                                                                      fontSize:
                                                                          FontSize
                                                                              .s14,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      text: registerCubit
                                                                              .companiesDataModel
                                                                              .result
                                                                              .responseModel[index]
                                                                              .companyName ??
                                                                          'Select The Company'),
                                                                ),
                                                              ),
                                                            ),
                                                            onSelectedItemChanged:
                                                                (index) {
                                                              registerCubit.changeCompany(
                                                                  registerCubit
                                                                      .companiesDataModel
                                                                      .result
                                                                      .responseModel[index]);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButtonCustom(
                                                    text: 'Done',
                                                    fontSize: FontSize.s14,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: TextCustom(
                                      color: ColorManager.primary,
                                      fontSize: FontSize.s14,
                                      text: registerCubit.companyName.isEmpty
                                          ? 'Select The Company'
                                          : registerCubit.companyName,
                                    ),
                                  ),
                                )
                              : ShimmerCustom(
                                  child: SizedBox(
                                  height: AppSize.s50,
                                  child: DropdownMenu(
                                      width: context.width / 1.1,
                                      hintText: 'Select the company',
                                      key: const Key('2'),
                                      inputDecorationTheme:
                                          InputDecorationTheme(
                                        filled: true,
                                        fillColor: ColorManager.textFormColor,
                                        isDense: true,
                                        //floatingLabelBehavior: FloatingLabelBehavior.auto,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(AppSize.s8),
                                          borderSide: const BorderSide(
                                            color: ColorManager.textFormColor,
                                            width: AppSize.s1_5,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(AppSize.s8),
                                          borderSide: const BorderSide(
                                            color: ColorManager.textFormColor,
                                            width: AppSize.s1_5,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: AppPadding.p8,
                                          horizontal: AppPadding.p16,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(AppSize.s8),
                                          borderSide: const BorderSide(
                                            color: ColorManager.textFormColor,
                                            width: AppSize.s1_5,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(AppSize.s8),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: AppSize.s1_5,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(AppSize.s8),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        suffixIconColor:
                                            ColorManager.textFormIconColor,
                                        focusColor: ColorManager.textFormColor,
                                      ),
                                      enabled: false,
                                      trailingIcon: const Icon(
                                        Icons.arrow_drop_down_rounded,
                                        color: ColorManager.primary,
                                      ),
                                      dropdownMenuEntries: const []),
                                )),
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      TextCustom(
                        fontSize: FontSize.s14,
                        text: AppStrings.name,
                        textAlign: TextAlign.start,
                        color: ColorManager.textFormLabelColor,
                      ),
                      const SizedBox(
                        height: AppSize.s4,
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
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      TextCustom(
                        fontSize: FontSize.s14,
                        text: AppStrings.email,
                        textAlign: TextAlign.start,
                        color: ColorManager.textFormLabelColor,
                      ),
                      const SizedBox(
                        height: AppSize.s4,
                      ),
                      TextFormFieldCustom(
                        controller: registerCubit.emailController,
                        validate: (value) {
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
                        text: AppStrings.phone,
                        textAlign: TextAlign.start,
                        color: ColorManager.textFormLabelColor,
                      ),
                      const SizedBox(
                        height: AppSize.s4,
                      ),
                      TextFormFieldCustom(
                        controller: registerCubit.phoneNumberController,
                        validate: (value) {
                          if (value!.trim().isEmpty || value == ' ') {
                            return AppStrings.phoneTextField;
                          }
                          return null;
                        },
                        prefix: true, isRegister: true,
                        hint: "5x xxx xxxx",
                        keyboardType: TextInputType.phone,
                        suffixIcon: IconsAssets.phoneIcon,
                        suffix: true,

                        // textInputAction: TextInputAction.done,
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
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      TextCustom(
                        fontSize: FontSize.s14,
                        text: AppStrings.employeeCode,
                        textAlign: TextAlign.start,
                        color: ColorManager.textFormLabelColor,
                      ),
                      const SizedBox(
                        height: AppSize.s4,
                      ),
                      TextFormFieldCustom(
                        controller: registerCubit.employeeCode,
                        validate: (value) {
                          if (value!.trim().isEmpty || value == ' ') {
                            return AppStrings.nameTextField;
                          }

                          return null;
                        },
                        keyboardType: TextInputType.number,
                        suffixIcon: IconsAssets.personIcon,
                        suffix: true,
                      ),
                      const SizedBox(
                        height: AppSize.s40,
                      ),
                      Center(
                        child: state is RegisterLoadingState
                            ? const CupertinoActivityIndicator(
                                color: ColorManager.primary,
                                radius: AppSize.s16,
                              )
                            : ElevatedButtonCustom(
                                fontSize: FontSize.s14,
                                textColor: ColorManager.white,
                                onPressed: () async {
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
                            fontSize: FontSize.s14,
                            text: AppStrings.haveAccount,
                            color: ColorManager.grey,
                            fontWeight: FontWeight.w600,
                          ),
                          TextButton(
                            onPressed: () {
                              navigatorAndRemove(context, Routes.loginRoute);
                            },
                            child: TextCustom(
                                color: ColorManager.primary,
                                fontSize: FontSize.s14,
                                text: AppStrings.login,
                                decoration: TextDecoration.underline),
                          ),
                          const SizedBox(
                            height: AppSize.s40,
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
