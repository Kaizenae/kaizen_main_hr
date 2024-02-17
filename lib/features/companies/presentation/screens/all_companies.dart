import 'package:Attendace/core/utils/media_query_values.dart';
import 'package:Attendace/core/utils/values_manager.dart';
import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/features/companies/presentation/cubit/companies_state.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../cubit/companies_cubit.dart';

class AllCompaniesScreen extends StatelessWidget {
  const AllCompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s24,
        ),
        TextCustom(
          fontSize: FontSize.s14.sp,
          text: 'Companies',
          textAlign: TextAlign.start,
          color: ColorManager.textFormLabelColor,
        ),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            // TextFormFieldCustom(
            //     enable: false,
            //     controller: TextEditingController(text: '${BlocProvider.of<AllUsersCubit>(context).users.length}'),
            //     validate: (validate) {}),
            InkWell(
              onTap: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.noHeader,
                  width: double.infinity,
                  desc: '',
                  showCloseIcon: true,
                  body: Padding(
                    padding: const EdgeInsets.all(AppPadding.p18),
                    child: Column(
                      children: [
                        TextCustom(
                          text: 'Companies',
                          color: ColorManager.primary,
                          fontSize: FontSize.s20,
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<CompaniesCubit>(context)
                            ..getCompaniesFun(),
                          child: BlocConsumer<CompaniesCubit, CompaniesState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return state is GetCompaniesSuccess
                                  ? SizedBox(
                                      height: context.height / 3,
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                          onTap: () {
                                            // allUsersCubit.addUsers(state
                                            //     .allUsersEntity
                                            //     .profileDataEntity[index]
                                            //     .sId);
                                            // print(allUsersCubit.users);
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(
                                                AppPadding.p8),
                                            margin: const EdgeInsets.all(
                                                AppPadding.p8),
                                            decoration: BoxDecoration(
                                              color: ColorManager.primary,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSize.s8),
                                            ),
                                            child: Column(
                                              children: [
                                                TextCustom(
                                                  text: state
                                                      .companiesEntity
                                                      .resultEntity
                                                      .response[index]
                                                      .name,
                                                  color: ColorManager.white,
                                                  fontSize: FontSize.s16,
                                                ),
                                                // TextCustom(
                                                //   text: state
                                                //       .allUsersEntity
                                                //       .profileDataEntity[index]
                                                //       .department,
                                                //   color: ColorManager.white,
                                                //   fontSize: FontSize.s14,
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        itemCount: state.companiesEntity
                                            .resultEntity.response.length,
                                      ),
                                    )
                                  : state is GetCompaniesLoading
                                      ? ShimmerCustom(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) =>
                                                Container(
                                              padding: const EdgeInsets.all(
                                                  AppPadding.p8),
                                              margin: const EdgeInsets.all(
                                                  AppPadding.p8),
                                              decoration: BoxDecoration(
                                                color: ColorManager.primary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.s8),
                                              ),
                                              child: Column(
                                                children: [
                                                  TextCustom(
                                                    text: '',
                                                    color: ColorManager.white,
                                                    fontSize: FontSize.s16,
                                                  ),
                                                  TextCustom(
                                                    text: '',
                                                    color: ColorManager.white,
                                                    fontSize: FontSize.s14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            itemCount: 4,
                                          ),
                                        )
                                      : ErrorsWidget(
                                          onPress: () {
                                            BlocProvider.of<CompaniesCubit>(
                                                    context)
                                                .getCompaniesFun();
                                          },
                                        );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ).show();
              },
              child: Container(
                margin: const EdgeInsets.only(
                    right: AppSize.s12, top: AppSize.s10, bottom: AppSize.s10),
                height: AppSize.s30,
                width: AppSize.s60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    color: ColorManager.secondary),
                child: Center(
                  child: TextCustom(
                    text: 'Add',
                    color: ColorManager.white,
                    fontSize: FontSize.s12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
