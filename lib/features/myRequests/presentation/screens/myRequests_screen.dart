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
import 'package:Attendace/features/myRequests/presentation/controller/myRequests_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import 'package:flutter/material.dart';
import '../controller/myRequests_state.dart';
import '../widgets/approved_widget.dart';
import '../widgets/pending_widget.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: AppStrings.myRequests,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: SafeArea(
          child: Column(
            children: [
              BlocProvider.value(
                value: BlocProvider.of<MyRequestsCubit>(context)
                  ..getMyRequestsFun(),
                child: BlocConsumer<MyRequestsCubit, MyRequestsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppPadding.p12),
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(AppSize.s10),
                          ),
                          child: Column(
                            children: [
                              TextCustom(
                                text: state is GetMyRequestsSuccess
                                    ? '${state.myRequestsEntity.resultEntity.response.length}'
                                    : '0',
                                color: ColorManager.secondary,
                                fontSize: FontSize.s32,
                                fontWeight: FontWeight.w600,
                              ),
                              TextCustom(
                                text: 'Total Requests',
                                color: ColorManager.black,
                                fontSize: FontSize.s18,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(AppPadding.p12),
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(AppSize.s10),
                          ),
                          child: Column(
                            children: [
                              TextCustom(
                                text: state is GetMyRequestsPendingSuccess
                                    ? '${state.myRequestsEntity.resultEntity.response.length}'
                                    : '0',
                                color: ColorManager.secondary,
                                fontSize: FontSize.s32,
                                fontWeight: FontWeight.w600,
                              ),
                              TextCustom(
                                text: 'Used Requests',
                                color: ColorManager.black,
                                fontSize: FontSize.s18,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
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
                  navigator(context, Routes.createRequestRoute);
                },
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              TabBarCustom(
                onTap: (v) {
                  if (v == 0) {
                    MyRequestsCubit.get(context).getMyRequestsFun();
                  } else if (v == 1) {
                    MyRequestsCubit.get(context).getMyRequestsPendingFun();
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

              // Expanded(
              //   child: CupertinoTabScaffold(
              //     backgroundColor: ColorManager.scaffoldColor,
              //     tabBar: CupertinoTabBar(
              //       backgroundColor: ColorManager.white,
              //
              //       onTap: (v) {
              //         if (v == 0) {
              //           MyRequestsCubit.get(context).getMyRequestsFun();
              //         } else if (v == 1) {
              //           MyRequestsCubit.get(context).getMyRequestsPendingFun();
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
