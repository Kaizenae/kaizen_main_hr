import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../widgets/trainee_widget.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: "Task Title",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Task Type",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Oct 12, 2020",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 16, color: ColorManager.darkPurple),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                "Trainees",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: ColorManager.primary,
                    ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return const TraineeWidget();
                },
                childCount: 10, // Number of items in the list
              ),
            ),
          ],
        ),
      ),
    );
  }
}
