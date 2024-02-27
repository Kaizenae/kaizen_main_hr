import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/utils/values_manager.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/tab_bar_custom/tab_bar_custom.dart';
import '../../../myRequests/presentation/controller/myRequests_cubit.dart';
import '../../../myTimeOff/presentation/controller/myTimeOff_cubit.dart';
import '../widgets/pending_time_widget.dart';
import '../widgets/pending_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: SafeArea(
          child: Column(
            children: [
              TabBarCustom(
                onTap: (v) {
                  if (v == 0) {
                    MyRequestsCubit.get(context).getMyRequestsPendingFun();
                  } else if (v == 1) {
                    MyTimeOffCubit.get(context).getAllTimeOffFun();
                  }
                },
                widgets: const [
                  PendingWidget(),
                  PendingTimeWidget(),
                ],
                myTabs: const [
                  Tab(
                    text: AppStrings.requests,
                  ),
                  Tab(
                    text: AppStrings.timeOffRequests,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
