import 'package:Attendace/features/projects/presentation/screens/tasks_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/animation/slide_transtion.dart';
import '../../../../core/utils/color_manager.dart';

class ProjectsWidget extends StatelessWidget {
  const ProjectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            SlideTranstion(page: const TasksScreen()),
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
                "Project Name",
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
                  "Oct 12, 2020 - Oct 12, 2020",
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
                  "Akhil Retnan",
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 1,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "PO Box: Dubai, Dubai, UAE.",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                          color: ColorManager.purple, shape: BoxShape.circle),
                      child: const Icon(
                        Icons.location_on_outlined,
                        size: 26,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      itemCount: 10,
    );
  }
}
