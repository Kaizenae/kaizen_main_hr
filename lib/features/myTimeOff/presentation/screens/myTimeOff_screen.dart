// ignore_for_file: file_names

import 'dart:developer';

import 'package:Attendace/core/utils/font_manager.dart';
import 'package:Attendace/core/utils/media_query_values.dart';
import 'package:Attendace/core/utils/routes_manager.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
import 'package:Attendace/core/widgets/component.dart';
import 'package:Attendace/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:Attendace/core/widgets/tab_bar_custom/tab_bar_custom.dart';
import 'package:Attendace/features/myTimeOff/presentation/controller/myTimeOff_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/values_manager.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../controller/myTimeOff_state.dart';
import '../widgets/approved_widget.dart';
import '../widgets/pending_time_widget.dart';
import '../widgets/refuse_widget.dart';

class MyTimeOffScreen extends StatelessWidget {
  const MyTimeOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MyTimeOffCubit>(context)..getAllTimeOffValues(),
      child: ScaffoldCustom(
        appBarCustom: const AppBarCustom(
          text: AppStrings.myTimeOff,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: SafeArea(
            child: Column(
              children: [
                BlocConsumer<MyTimeOffCubit, MyTimeOffState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    log(state.toString());
                    return SizedBox(
                      height: AppSize.s120,
                      child: BlocProvider.of<MyTimeOffCubit>(context)
                              .allTimeOffValueModel
                              .result
                              .responseModel
                              .isNotEmpty
                          ? ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(AppPadding.p12),
                                  decoration: BoxDecoration(
                                    color: ColorManager.white,
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: TextCustom(
                                          text: BlocProvider.of<MyTimeOffCubit>(
                                                      context)
                                                  .allTimeOffNameAndValues[
                                              index]["timeOffValue"],
                                          color: ColorManager.secondary,
                                          fontSize: FontSize.s20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: TextCustom(
                                          text: BlocProvider.of<MyTimeOffCubit>(
                                                      context)
                                                  .allTimeOffNameAndValues[
                                              index]["timeOffName"],
                                          color: ColorManager.black,
                                          fontSize: FontSize.s18,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: AppSize.s12,
                                );
                              },
                              itemCount:
                                  BlocProvider.of<MyTimeOffCubit>(context)
                                      .allTimeOffNameAndValues
                                      .length)
                          : Center(
                              child: Text(
                                AppStrings.youDontHaveLeaveBalance,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ),
                    );
                  },
                ),

                const SizedBox(
                  height: AppSize.s16,
                ),
                ElevatedButtonCustom(
                  fontSize: FontSize.s14,
                  colors: ColorManager.secondary,
                  width: context.width / 1.6,
                  text: 'Apply Request',
                  onPressed: () {
                    navigator(context, Routes.createTimeOffRoute);
                  },
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),

                const TabBarCustom(
                  widgets: [
                    PendingTimeWidget(),
                    ApprovedWidget(),
                    RefusedWidget(),
                  ],
                  myTabs: [
                    Tab(
                      text: AppStrings.pending,
                    ),
                    Tab(
                      text: AppStrings.approved,
                    ),
                    Tab(
                      text: AppStrings.rejected,
                    )
                  ],
                )

                // Expanded(
                //   child: CupertinoTabScaffold(
                //     backgroundColor: ColorManager.scaffoldColor,
                //     tabBar: CupertinoTabBar(
                //       backgroundColor: ColorManager.white,
                //
                //       onTap: (v) {
                //         if (v == 0) {
                //           MyTimeOffCubit.get(context).getMyTimeOffFun();
                //         } else if (v == 1) {
                //           MyTimeOffCubit.get(context).getMyTimeOffPendingFun();
                //         }
                //       },
                //       items: const <BottomNavigationBarItem>[
                //         BottomNavigationBarItem(
                //           icon: Icon(CupertinoIcons.check_mark_circled),
                //           label: AppStrings.approved,
                //         ),
                //         BottomNavigationBarItem(
                //           icon: Icon(CupertinoIcons.clock),
                //           label: AppStrings.pending,
                //         ),
                //
                //       ],
                //     ),
                //     tabBuilder: (BuildContext context, int index) {
                //       return CupertinoTabView(
                //         builder: (BuildContext context) {
                //           switch (index) {
                //             case 0:
                //               return ApprovedWidget();
                //             case 1:
                //               return PendingWidget();
                //             default:
                //               return ApprovedWidget();
                //           }
                //         },
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
