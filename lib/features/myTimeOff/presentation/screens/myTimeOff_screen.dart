// ignore_for_file: file_names

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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import 'package:flutter/material.dart';
import '../controller/myTimeOff_state.dart';
import '../widgets/approved_widget.dart';
import '../widgets/pending_time_widget.dart';
import '../widgets/refuse_widget.dart';

class MyTimeOffScreen extends StatelessWidget {
  const MyTimeOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: AppStrings.myTimeOff,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.r),
        child: SafeArea(
          child: Column(
            children: [
              BlocProvider.value(
                value: BlocProvider.of<MyTimeOffCubit>(context)
                  ..getMyTimeOffFun(),
                child: BlocConsumer<MyTimeOffCubit, MyTimeOffState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.all(AppPadding.p12.r),
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(AppSize.s10.r),
                          ),
                          child: Column(
                            children: [
                              TextCustom(
                                text: '21',
                                color: ColorManager.secondary,
                                fontSize: FontSize.s32.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              TextCustom(
                                text: 'Total TimeOff',
                                color: ColorManager.black,
                                fontSize: FontSize.s18.sp,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(AppPadding.p12.r),
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(AppSize.s10.r),
                          ),
                          child: Column(
                            children: [
                              TextCustom(
                                text: state is GetMyTimeOffSuccess
                                    ? '${state.myTimeOffEntity.resultEntity.response.length}'
                                    : '0',
                                color: ColorManager.secondary,
                                fontSize: FontSize.s32.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              TextCustom(
                                text: 'Used TimeOff',
                                color: ColorManager.black,
                                fontSize: FontSize.s18.sp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: AppSize.s16.h,
              ),
              ElevatedButtonCustom(
                colors: ColorManager.secondary,
                width: context.width / 1.6,
                text: 'Apply Request',
                onPressed: () {
                  navigator(context, Routes.createTimeOffRoute);
                },
              ),
              SizedBox(
                height: AppSize.s18.h,
              ),
              TabBarCustom(
                onTap: (v) {
                  MyTimeOffCubit.get(context).getMyTimeOffFun();
                },
                widgets: const [
                  ApprovedWidget(),
                  PendingTimeWidget(),
                  RefusedWidget(),
                ],
                myTabs: const [
                  Tab(
                    text: AppStrings.approved,
                  ),
                  Tab(
                    text: AppStrings.pending,
                  ),
                  Tab(
                    text: AppStrings.refuse,
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
    );
  }
}
