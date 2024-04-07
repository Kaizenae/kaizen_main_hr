// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../../../../core/utils/strings_manager.dart';
import '../controller/cubit.dart';
import 'early_and_late_list.dart';

class ApprovedWidget extends StatelessWidget {
  ApprovedWidget({
    super.key,
    required this.title,
    required this.state,
  });
  final String title;
  late List doneList;
  var state;
  @override
  Widget build(BuildContext context) {
    if (title == AppStrings.earlyOutRequest) {
      doneList = EarlyOutLateInCubit.get(context).earlyOutDone;
      return EarlyAndLateList(
        list: doneList,
        title: title,
        state: state,
        isPending: false,
      );
    } else if (title == AppStrings.lateInRequest) {
      doneList = EarlyOutLateInCubit.get(context).lateInDone;
      return EarlyAndLateList(
        list: doneList,
        state: state,
        isPending: false,
        title: title,
      );
    } else {
      return const SizedBox();
    }
  }
}
