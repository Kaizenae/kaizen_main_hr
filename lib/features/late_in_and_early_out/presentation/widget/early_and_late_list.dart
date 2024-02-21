import 'package:Attendace/features/late_in_and_early_out/presentation/widget/early_out_late_in_item.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/strings_manager.dart';
import '../../../../core/widgets/error_widget.dart';

class EarlyAndLateList extends StatelessWidget {
  const EarlyAndLateList({
    super.key,
    required this.list,
    required this.title,
  });
  final List list;
  final String title;
  @override
  Widget build(BuildContext context) {
    if (title == AppStrings.lateInRequest) {
      if (list.isEmpty) {
        return const ErrorsWidget();
      } else {
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => EarlyOutLateInItem(
            item: list[index],
            title: title,
          ),
          itemCount: list.length,
        );
      }
    } else if (title == AppStrings.earlyOutRequest) {
      if (list.isEmpty) {
        return const ErrorsWidget();
      } else {
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => EarlyOutLateInItem(
            item: list[index],
            title: title,
          ),
          itemCount: list.length,
        );
      }
    } else {
      return const SizedBox();
    }
  }
}
