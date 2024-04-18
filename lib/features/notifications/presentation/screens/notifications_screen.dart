import 'package:Attendace/core/utils/values_manager.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:Attendace/features/notifications/presentation/widgets/approved_requests_widget.dart';
import 'package:Attendace/features/notifications/presentation/widgets/rejected_requests_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/widgets/tab_bar_custom/tab_bar_custom.dart';
import '../controllers/requests_controller/bloc.dart';
import '../widgets/pending_requests_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<RequestsBloc>(context)..getRequests(),
      child: ScaffoldCustom(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                TabBarCustom(
                  widgets: [
                    PendingRequestsWidget(),
                    ApprovedRequestsWidget(),
                    const RejectedRequestsWidget(),
                  ],
                  myTabs: const [
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
