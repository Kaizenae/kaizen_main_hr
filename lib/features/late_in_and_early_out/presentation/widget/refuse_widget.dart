// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../../../../core/utils/strings_manager.dart';
import '../controller/cubit.dart';
import 'early_and_late_list.dart';

class RefusedWidget extends StatelessWidget {
  RefusedWidget({
    super.key,
    required this.title,
    required this.state,
  });
  final String title;
  late List refuseList;
  var state;
  @override
  Widget build(BuildContext context) {
    if (title == AppStrings.earlyOutRequest) {
      refuseList = EarlyOutLateInCubit.get(context).earlyOutRefuse;
      return EarlyAndLateList(
        list: refuseList,
        isPending: false,
        title: title,
        state: state,
      );
    } else if (title == AppStrings.lateInRequest) {
      refuseList = EarlyOutLateInCubit.get(context).lateInRefuse;
      return EarlyAndLateList(
        list: refuseList,
        state: state,
        title: title,
        isPending: false,
      );
    } else {
      return const SizedBox();
    }
  }
}
