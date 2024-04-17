import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../data/shift_allocation_model.dart';

class ShiftAllocationItem extends StatelessWidget {
  const ShiftAllocationItem({
    super.key,
    required this.item,
  });
  final ResponseModel item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: TextCustom(
                fontSize: FontSize.s14,
                text:
                    DateFormat("dd,MMM,yyyy").format(DateTime.parse(item.from)),
                color: ColorManager.primary,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: TextCustom(
                fontSize: FontSize.s14,
                text: DateFormat("dd,MMM,yyyy").format(DateTime.parse(item.to)),
                color: ColorManager.primary,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: TextCustom(
                fontSize: FontSize.s14,
                text: item.shiftScheme.name,
                color: ColorManager.error,
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: TextCustom(
                fontSize: FontSize.s14,
                text: item.state,
                color: ColorManager.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
