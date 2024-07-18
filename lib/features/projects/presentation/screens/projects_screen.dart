import 'package:flutter/material.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../widgets/projects_widget.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldCustom(
      appBarCustom: AppBarCustom(
        text: AppStrings.projects,
      ),
      body: ProjectsWidget(),
    );
  }
}
