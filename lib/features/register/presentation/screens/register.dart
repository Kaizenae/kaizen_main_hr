// ignore_for_file: use_build_context_synchronously

import 'package:Attendace/core/utils/font_manager.dart';
import 'package:Attendace/features/register/domain/usecases/register_usecase.dart';
import 'package:Attendace/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';
import '../widgets/register_form_widget.dart';
import '../widgets/select_company_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                  content: Text(
                      state.registerEntity.resultEntity.message.toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              navigatorAndRemove(context, Routes.loginRoute);
            } else if (state is RegisterErrorState) {
              SnackBar snackBar =
                  SnackBar(content: Text(state.message.toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
<<<<<<< HEAD
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: 3 / 1.2,
                        child: Image.asset(
                          ImageAssets.logoImg,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSize.s30),
                    SelectCompanyWidget(
                        registerCubit: RegisterCubit.get(context)),
                    const SizedBox(
                      height: AppSize.s30,
                    ),
                    RegisterFormWidget(
                      formKey: formKey,
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
                                if (formKey.currentState!.validate()) {
                                  await RegisterCubit.get(context)
                                      .registerFun();
                                  formKey.currentState!.reset();
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
=======
            var registerCubit = RegisterCubit.get(context);
            return CustomScrollView(
              slivers: [
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
                      padding: const EdgeInsets.all(AppPadding.p16),
                      child: Form(
                        key: registerCubit.formKey,
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
                              color: ColorManager.white,
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
                                            borderRadius: BorderRadius.circular(
                                                AppSize.s8)),
                                        width: context.width / 1.1,
                                        height: AppSize.s50,
                                        child: InkWell(
                                          onTap: () {
                                            showCupertinoModalPopup<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    height: AppSize.s100 * 3,
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
                                                              fontSize: 18.0,
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

                                                                  children: List
                                                                      .generate(
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
                                                                            color:
                                                                                ColorManager.primary,
                                                                            fontSize: FontSize.s14,
                                                                            textAlign: TextAlign.center,
                                                                            text: registerCubit.companiesDataModel.result.responseModel[index].companyName ?? 'Select The Company'),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  onSelectedItemChanged:
                                                                      (index) {
                                                                    registerCubit.changeCompany(registerCubit
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
                                                          fontSize:
                                                              FontSize.s14,
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
                                            color: ColorManager.primary,
                                            fontSize: FontSize.s14,
                                            text: registerCubit
                                                    .companyName.isEmpty
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
                                              fillColor:
                                                  ColorManager.textFormColor,
                                              isDense: true,
                                              //floatingLabelBehavior: FloatingLabelBehavior.auto,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.s8),
                                                borderSide: const BorderSide(
                                                  color: ColorManager
                                                      .textFormColor,
                                                  width: AppSize.s1_5,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.s8),
                                                borderSide: const BorderSide(
                                                  color: ColorManager
                                                      .textFormColor,
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
                                                    BorderRadius.circular(
                                                        AppSize.s8),
                                                borderSide: const BorderSide(
                                                  color: ColorManager
                                                      .textFormColor,
                                                  width: AppSize.s1_5,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.s8),
                                                borderSide: const BorderSide(
                                                  color: Colors.red,
                                                  width: AppSize.s1_5,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.s8),
                                                borderSide: const BorderSide(
                                                  color: Colors.red,
                                                ),
                                              ),
                                              suffixIconColor: ColorManager
                                                  .textFormIconColor,
                                              focusColor:
                                                  ColorManager.textFormColor,
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
                              color: ColorManager.white,
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
                              color: ColorManager.white,
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
                              color: ColorManager.white,
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
                              color: ColorManager.white,
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
                              color: ColorManager.white,
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
                                      color: Color(0xff8845A9),
                                      radius: AppSize.s16,
                                    )
                                  : ElevatedButtonCustom(
                                      fontSize: FontSize.s14,
                                      textColor: ColorManager.white,
                                      onPressed: () async {
                                        if (registerCubit.formKey.currentState!
                                            .validate()) {
                                          await registerCubit.registerFun();
                                          registerCubit.formKey.currentState!
                                              .reset();
                                        }
                                      },
                                      colors: const Color(0xff8845A9),
                                      borderColor: const Color(0xff8845A9),
                                      text: AppStrings.register,
                                    ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextCustom(
                                  fontSize: FontSize.s14,
                                  text: AppStrings.haveAccount,
                                  color: ColorManager.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                TextButton(
                                  onPressed: () {
                                    navigatorAndRemove(
                                        context, Routes.loginRoute);
                                  },
                                  child: TextCustom(
                                    color: ColorManager.white,
                                    fontSize: FontSize.s14,
                                    text: AppStrings.login,
                                    decoration: TextDecoration.underline,
                                    decorationColor: ColorManager.white,
                                  ),
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
                  ),
>>>>>>> 1cabfa8fd74b0e1257a8454ecd599f0984433f52
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
