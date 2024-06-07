// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../controller/cubit.dart';
import 'early_and_late_list.dart';

class PendingWidget extends StatelessWidget {
  PendingWidget({
    super.key,
    required this.title,
    required this.state,
  });
  final String title;
  var state;
  late List pendingList;
  @override
  Widget build(BuildContext context) {
    if (title == AppStrings.earlyOutRequest) {
      pendingList = EarlyOutLateInCubit.get(context).earlyOutPending;
      return EarlyAndLateList(
        list: pendingList,
        bgStatusColor: ColorManager.yellow,
        statusColor: ColorManager.orange,
        title: title,
        isPending: true,
        state: state,
      );
    } else if (title == AppStrings.lateInRequest) {
      pendingList = EarlyOutLateInCubit.get(context).lateInPending;
      return EarlyAndLateList(
        list: pendingList,
        title: title,
        bgStatusColor: ColorManager.yellow,
        statusColor: ColorManager.orange,
        state: state,
        isPending: true,
      );
    } else {
      return const SizedBox();
    }
  }
}
