import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
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
        appBarCustom: const AppBarCustom(
          text: AppStrings.requests,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  backToHome({required BuildContext context}) {
    RequestsBloc.get(context).getRequests();
    Navigator.pop(context);
  }
}
