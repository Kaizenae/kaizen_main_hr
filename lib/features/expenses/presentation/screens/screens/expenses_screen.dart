import 'package:Attendace/core/utils/media_query_values.dart';
import 'package:Attendace/features/expenses/presentation/screens/screens/create_expenses_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/font_manager.dart';
import '../../../../../core/utils/strings_manager.dart';
import '../../../../../core/utils/values_manager.dart';
import '../../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../../core/widgets/tab_bar_custom/tab_bar_custom.dart';
import '../../widget/approved_widget.dart';
import '../../widget/pending_time_widget.dart';
import '../../widget/refuse_widget.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: AppStrings.expensesRequests,
      ),
      body: Padding(
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
                text: AppStrings.applyRequest,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateExpensesScreen(),
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
                const PendingWidget(),
                ApprovedWidget(),
                RefusedWidget(),
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
    );
  }
}
