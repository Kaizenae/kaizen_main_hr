import 'package:Attendace/features/expenses/presentation/screens/screens/create_expenses_screen.dart';
import 'package:flutter/material.dart';
import '../../../../../core/services/animation/slide_transtion.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/strings_manager.dart';
import '../../../../../core/widgets/app_bar/app_bar_custom.dart';
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
            SlideTranstion(page: const CreateExpensesScreen()),
          );
        },
      ),
      appBarCustom: const AppBarCustom(
        text: AppStrings.expensesRequests,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            TabBarCustom(
              widgets: [
                PendingWidget(),
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
            ),
          ],
        ),
      ),
    );
  }
}
