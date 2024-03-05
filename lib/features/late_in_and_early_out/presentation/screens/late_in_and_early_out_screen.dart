import 'package:Attendace/core/utils/media_query_values.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:Attendace/features/late_in_and_early_out/presentation/controller/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
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
        ..getEarlyOut()
        ..getLateIn(),
      child: ScaffoldCustom(
        appBarCustom: AppBarCustom(
          text: title,
        ),
        body: BlocBuilder<EarlyOutLateInCubit, EarlyOutLateInStates>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  const SizedBox(
                    height: AppSize.s16,
                  ),
                  Center(
                    child: ElevatedButtonCustom(
                      fontSize: FontSize.s14,
                      colors: ColorManager.secondary,
                      width: context.width / 1.6,
                      text: 'Apply Request',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateLateInEarlyOutScreen(
                              title: title,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  TabBarCustom(
                    widgets: [
                      ApprovedWidget(
                        title: title,
                      ),
                      PendingWidget(
                        title: title,
                      ),
                      RefusedWidget(
                        title: title,
                      ),
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
