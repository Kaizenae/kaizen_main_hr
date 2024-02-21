import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:Attendace/features/shift_allocation/presentation/controller/shift_allocation_states.dart';
import 'package:Attendace/features/shift_allocation/presentation/widget/shift_allocation_item.dart';
import 'package:Attendace/features/shift_allocation/presentation/controller/shift_allocation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class ShiftAllocationScreen extends StatelessWidget {
  const ShiftAllocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShiftAllocationCubit()..getShiftAllocation(),
      child: ScaffoldCustom(
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
              Expanded(child:
                  BlocBuilder<ShiftAllocationCubit, ShiftAllocationStates>(
                builder: (context, state) {
                  return ShiftAllocationCubit.get(context)
                          .shiftAllocationModel
                          .result
                          .responseModel
                          .isEmpty
                      ? const ErrorsWidget()
                      : ListView.separated(
                          itemBuilder: (context, index) => ShiftAllocationItem(
                            item: ShiftAllocationCubit.get(context)
                                .shiftAllocationModel
                                .result
                                .responseModel[index],
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                          itemCount: ShiftAllocationCubit.get(context)
                              .shiftAllocationModel
                              .result
                              .responseModel
                              .length,
                        );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
