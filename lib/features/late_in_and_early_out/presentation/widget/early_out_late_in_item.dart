import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../myLoans/presentation/widgets/userRequest_widget.dart';
import '../../data/late_in_early_out_model.dart';

class EarlyOutLateInItem extends StatelessWidget {
  const EarlyOutLateInItem({
    super.key,
    required this.item,
    required this.title,
  });
  final ResponseModel item;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: SizedBox(
        child: Column(
          children: [
            UserRequestWidget(
              iconPath: IconsAssets.emailIcon,
              text: AppStrings.message,
              subText: title,
            ),
            UserRequestWidget(
                iconPath: IconsAssets.calenderIcon,
                text: AppStrings.date,
                subText: DateFormat('EEE, MMM, dd, yyyy')
                    .format(DateTime.parse(item.date))),
            UserRequestWidget(
                iconPath: IconsAssets.messageQuestionIcon,
                text: AppStrings.message,
                subText: item.reason),
            UserRequestWidget(
                iconPath: IconsAssets.clockIcon,
                text: AppStrings.status,
                subText: item.state),
          ],
        ),
      ),
    );
  }
}
