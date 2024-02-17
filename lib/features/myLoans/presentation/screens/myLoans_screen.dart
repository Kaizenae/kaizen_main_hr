// ignore_for_file: file_names

import 'dart:io';

import 'package:Attendace/core/utils/font_manager.dart';
import 'package:Attendace/core/utils/media_query_values.dart';
import 'package:Attendace/core/utils/routes_manager.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
import 'package:Attendace/core/widgets/component.dart';
import 'package:Attendace/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:Attendace/core/widgets/tab_bar_custom/tab_bar_custom.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import 'package:flutter/material.dart';
import '../controller/myLoans_cubit.dart';
import '../controller/myLoans_state.dart';
import '../widgets/approved_widget.dart';
import '../widgets/pending_widget.dart';

class MyLoansScreen extends StatelessWidget {
  const MyLoansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: AppStrings.myLoans,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.r),
        child: SafeArea(
          child: Column(
            children: [
              BlocBuilder<MyLoansCubit, MyLoansState>(
                builder: (context, state) {
                  var loansCubit = MyLoansCubit.get(context);
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
                              text: state is GetMyLoansSuccess
                                  ? '${loansCubit.myLoansPending.length + loansCubit.myLoans.length}'
                                  : '0',
                              color: ColorManager.secondary,
                              fontSize: FontSize.s32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            TextCustom(
                              text: 'Total Loans',
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
                              text: state is GetMyLoansSuccess
                                  ? '${loansCubit.myLoans.length}'
                                  : '0',
                              color: ColorManager.secondary,
                              fontSize: FontSize.s32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            TextCustom(
                              text: 'Used Loans',
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
              SizedBox(
                height: AppSize.s16.h,
              ),
              ElevatedButtonCustom(
                fontSize: FontSize.s14.sp,
                colors: ColorManager.secondary,
                width: context.width / 1.6,
                text: 'Apply Request',
                onPressed: () {
                  navigator(context, Routes.createLoanRoute);
                },
              ),
              SizedBox(
                height: AppSize.s18.h,
              ),
              Platform.isAndroid
                  ? TabBarCustom(
                      onTap: (v) {
                        if (v == 0) {
                          MyLoansCubit.get(context).getMyLoansFun();
                        } else if (v == 1) {
                          MyLoansCubit.get(context).getMyLoansFun();
                        }
                      },
                      widgets: const [
                        ApprovedWidget(),
                        PendingWidget(),
                      ],
                      myTabs: const [
                        Tab(
                          text: AppStrings.approved,
                        ),
                        Tab(
                          text: AppStrings.pending,
                        )
                      ],
                    )
                  : Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: <Widget>[
                            ButtonsTabBar(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p12),
                              backgroundColor: ColorManager.primary,
                              unselectedBackgroundColor: Colors.grey[300],
                              unselectedLabelStyle:
                                  const TextStyle(color: Colors.black),
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: FontSize.s20),
                              tabs: const [
                                Tab(
                                  // icon: Icon(Icons.directions_car),
                                  text: AppStrings.approved,
                                ),
                                Tab(
                                  // icon: Icon(Icons.directions_transit),
                                  text: AppStrings.pending,
                                ),
                              ],
                            ),
                            const Expanded(
                              child: TabBarView(
                                children: <Widget>[
                                  ApprovedWidget(),
                                  PendingWidget(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

              // Expanded(
              //   child: CupertinoTabScaffold(
              //     backgroundColor: ColorManager.scaffoldColor,
              //     tabBar: CupertinoTabBar(
              //       backgroundColor: ColorManager.white,
              //
              //       onTap: (v) {
              //         if (v == 0) {
              //           MyLoansCubit.get(context).getMyLoansFun();
              //         } else if (v == 1) {
              //           MyLoansCubit.get(context).getMyLoansPendingFun();
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
