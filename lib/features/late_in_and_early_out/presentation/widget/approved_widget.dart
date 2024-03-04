// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../../../core/utils/strings_manager.dart';
import '../controller/cubit.dart';
import 'early_and_late_list.dart';

class ApprovedWidget extends StatelessWidget {
  ApprovedWidget({
    super.key,
    required this.title,
  });
  final String title;
  late List doneList;
  @override
  Widget build(BuildContext context) {
    if (title == AppStrings.earlyOutRequest) {
      doneList = EarlyOutLateInCubit.get(context).earlyOutDone;
      return EarlyAndLateList(
        list: doneList,
        title: title,
      );
    } else if (title == AppStrings.lateInRequest) {
      doneList = EarlyOutLateInCubit.get(context).lateInDone;
      return EarlyAndLateList(
        list: doneList,
        title: title,
      );
    } else {
      return const SizedBox();
    }
  }
}
