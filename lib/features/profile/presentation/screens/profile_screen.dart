import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import 'profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldCustom(
      appBarCustom: AppBarCustom(
        text: AppStrings.profile,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        child: ProfileCard(),
      ),
    );
  }
}
