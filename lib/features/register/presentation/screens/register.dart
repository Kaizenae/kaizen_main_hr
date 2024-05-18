// ignore_for_file: use_build_context_synchronously

import 'package:Attendace/core/utils/font_manager.dart';
import 'package:Attendace/core/widgets/snack_bar/snack_bar_widget.dart';
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
              ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                  message: state.registerEntity.resultEntity.message.toString(),
                  context: context));
              navigatorAndRemove(context, Routes.loginRoute);
            } else if (state is RegisterErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                  message: state.message.toString(), context: context));
            }
          },
          builder: (context, state) {
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
                        key: formKey,
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
                                      color: Color(0xff8845A9),
                                      radius: AppSize.s16,
                                    )
                                  : ElevatedButtonCustom(
                                      fontSize: FontSize.s14,
                                      textColor: ColorManager.white,
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          await registerCubit.registerFun();
                                          formKey.currentState!.reset();
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
