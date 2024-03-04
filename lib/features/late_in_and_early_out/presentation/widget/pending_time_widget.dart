// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../../../core/utils/strings_manager.dart';
import '../controller/cubit.dart';
import 'early_and_late_list.dart';

class PendingWidget extends StatelessWidget {
  PendingWidget({
    super.key,
    required this.title,
  });
  final String title;
  late List pendingList;
  @override
  Widget build(BuildContext context) {
    if (title == AppStrings.earlyOutRequest) {
      pendingList = EarlyOutLateInCubit.get(context).earlyOutPending;
      return EarlyAndLateList(
        list: pendingList,
        title: title,
      );
    } else if (title == AppStrings.lateInRequest) {
      pendingList = EarlyOutLateInCubit.get(context).lateInPending;
      return EarlyAndLateList(
        list: pendingList,
        title: title,
      );
    } else {
      return const SizedBox();
    }
  }
}
