import 'package:Attendace/core/utils/values_manager.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:flutter/material.dart';
import '../widgets/pending_time_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldCustom(
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p20),
        child: SafeArea(
          child: PendingTimeWidget(),
        ),
      ),
    );
  }
}
