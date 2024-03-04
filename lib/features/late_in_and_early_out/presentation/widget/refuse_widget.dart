// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../../../core/utils/strings_manager.dart';
import '../controller/cubit.dart';
import 'early_and_late_list.dart';

class RefusedWidget extends StatelessWidget {
  RefusedWidget({
    super.key,
    required this.title,
  });
  final String title;
  late List refuseList;
  @override
  Widget build(BuildContext context) {
    if (title == AppStrings.earlyOutRequest) {
      refuseList = EarlyOutLateInCubit.get(context).earlyOutRefuse;
      return EarlyAndLateList(
        list: refuseList,
        title: title,
      );
    } else if (title == AppStrings.lateInRequest) {
      refuseList = EarlyOutLateInCubit.get(context).lateInRefuse;
      return EarlyAndLateList(
        list: refuseList,
        title: title,
      );
    } else {
      return const SizedBox();
    }
  }
}
