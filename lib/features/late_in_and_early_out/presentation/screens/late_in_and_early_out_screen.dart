import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:Attendace/core/widgets/snack_bar/snack_bar_widget.dart';
import 'package:Attendace/features/late_in_and_early_out/presentation/controller/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/animation/slide_transtion.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/tab_bar_custom/tab_bar_custom.dart';
import '../controller/cubit.dart';
import '../widget/approved_widget.dart';
import '../widget/pending_time_widget.dart';
import '../widget/refuse_widget.dart';
import 'create_late_in_and_early_out_screen.dart';

class LateInAndEarlyOutScreen extends StatelessWidget {
  const LateInAndEarlyOutScreen({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EarlyOutLateInCubit()
        ..getLateIn()
        ..getEarlyOut(),
      child: ScaffoldCustom(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: ColorManager.primary,
          label: Row(
            children: [
              Text(
                AppStrings.apply,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.add,
                color: ColorManager.white,
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).push(
              SlideTranstion(
                page: CreateLateInEarlyOutScreen(
                  title: title,
                ),
              ),
            );
          },
        ),
        appBarCustom: AppBarCustom(
          text: title,
        ),
        body: BlocConsumer<EarlyOutLateInCubit, EarlyOutLateInStates>(
          listener: (context, state) {
            if (state is CancelMyRequestSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                  message: state.message.toString(), context: context));
              EarlyOutLateInCubit.get(context).getEarlyOut();
              EarlyOutLateInCubit.get(context).getLateIn();
            } else if (state is CancelMyRequestErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                  message: state.message.toString(), context: context));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  TabBarCustom(
                    widgets: [
                      PendingWidget(
                        title: title,
                        state: state,
                      ),
                      ApprovedWidget(
                        title: title,
                        state: state,
                      ),
                      RefusedWidget(
                        title: title,
                        state: state,
                      ),
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
            );
          },
        ),
      ),
    );
  }
}
