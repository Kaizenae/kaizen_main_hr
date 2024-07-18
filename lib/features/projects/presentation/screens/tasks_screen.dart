import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/animation/slide_transtion.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import 'create_task_screen.dart';
import 'task_details_screen.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorManager.primary,
        label: Row(
          children: [
            Text(
              AppStrings.create,
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
            SlideTranstion(page: const CreateTaskScreen()),
          );
        },
      ),
      appBarCustom: const AppBarCustom(
        text: AppStrings.tasks,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              SlideTranstion(page: const TaskDetailsScreen()),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.lightGrey.withOpacity(.1),
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Task Name",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Oct 12, 2020",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 16, color: ColorManager.darkPurple),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Task Type",
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  style: Theme.of(context).textTheme.headlineMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        itemCount: 10,
      ),
    );
  }
}
