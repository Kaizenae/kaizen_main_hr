import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:Attendace/core/widgets/shift_allocation_item/shift_allocation_item.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class ShiftAllocationScreen extends StatelessWidget {
  const ShiftAllocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: AppStrings.myShiftAllocation,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: TextCustom(
                    text: 'From',
                    color: ColorManager.black,
                    fontSize: AppSize.s16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: TextCustom(
                    text: 'To',
                    color: ColorManager.primary,
                    fontSize: AppSize.s16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: TextCustom(
                    text: 'Scheme',
                    color: ColorManager.error,
                    fontSize: AppSize.s16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: TextCustom(
                    text: 'State',
                    color: ColorManager.secondary,
                    fontSize: AppSize.s16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => const ShiftAllocationItem(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
