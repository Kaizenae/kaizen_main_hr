import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:Attendace/features/shift_allocation/presentation/controller/shift_allocation_states.dart';
import 'package:Attendace/features/shift_allocation/presentation/controller/shift_allocation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: BlocBuilder<ShiftAllocationCubit, ShiftAllocationStates>(
              builder: (context, state) {
            return state is ShiftAllocationLoadingState
                ? ShimmerCustom(
                    child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s20),
                        color: ColorManager.white,
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.lightGrey.withOpacity(.1),
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${AppStrings.date}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "00:00",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              fontSize: FontSize.s14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${AppStrings.hours}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "00:00",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                              color: ColorManager.error,
                                            ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${AppStrings.from}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        '00: 00',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontSize: FontSize.s14,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${AppStrings.to}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        '00: 00',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontSize: FontSize.s14,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    itemCount: 10,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 20,
                    ),
                  ))
                : state is ShiftAllocationSuccessState
                    ? ShiftAllocationCubit.get(context)
                            .shiftAllocationModel
                            .result
                            .responseModel
                            .isEmpty
                        ? const ErrorsWidget()
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s20),
                                  color: ColorManager.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorManager.lightGrey
                                          .withOpacity(.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  "${AppStrings.from}: ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  DateFormat("dd,MMM,yyyy")
                                                      .format(
                                                    DateTime.parse(
                                                      ShiftAllocationCubit.get(
                                                              context)
                                                          .shiftAllocationModel
                                                          .result
                                                          .responseModel[index]
                                                          .from,
                                                    ),
                                                  ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith(
                                                        fontSize: FontSize.s14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  "${AppStrings.to}: ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  DateFormat("dd,MMM,yyyy")
                                                      .format(
                                                    DateTime.parse(
                                                      ShiftAllocationCubit.get(
                                                              context)
                                                          .shiftAllocationModel
                                                          .result
                                                          .responseModel[index]
                                                          .to,
                                                    ),
                                                  ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith(
                                                        fontSize: FontSize.s14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  "${AppStrings.scheme}: ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  ShiftAllocationCubit.get(
                                                          context)
                                                      .shiftAllocationModel
                                                      .result
                                                      .responseModel[index]
                                                      .shiftScheme
                                                      .name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith(
                                                          fontSize:
                                                              FontSize.s14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "${AppStrings.state}: ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                          ),
                                        ),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            ShiftAllocationCubit.get(context)
                                                .shiftAllocationModel
                                                .result
                                                .responseModel[index]
                                                .state,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    fontSize: FontSize.s14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount: ShiftAllocationCubit.get(context)
                                .shiftAllocationModel
                                .result
                                .responseModel
                                .length,
                          )
                    : const ErrorsWidget();
          }),
        ),
      ),
    );
  }
}

/**
  BlocProvider(
      
      child: ScaffoldCustom(
        
        body: Container(
          padding: const EdgeInsets.all(AppPadding.p16),
          margin: const EdgeInsets.symmetric(
              horizontal: AppPadding.p16, vertical: AppPadding.p12),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(AppSize.s10),
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 
              Expanded(child:
                  BlocBuilder<ShiftAllocationCubit, ShiftAllocationStates>(
                builder: (context, state) {
                  return state is ShiftAllocationLoadingState
                      ? ShimmerCustom(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppPadding.p12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextCustom(
                                    fontSize: FontSize.s14,
                                    text: '20 sep',
                                    color: ColorManager.black,
                                  ),
                                  TextCustom(
                                    fontSize: FontSize.s14,
                                    text: '09:00 am',
                                    color: ColorManager.primary,
                                  ),
                                  TextCustom(
                                    fontSize: FontSize.s14,
                                    text: '06:00 pm',
                                    color: ColorManager.error,
                                  ),
                                ],
                              ),
                            ),
                            itemCount: 10,
                          ),
                        )
                      : state is ShiftAllocationSuccessState
                          ? ShiftAllocationCubit.get(context)
                                  .shiftAllocationModel
                                  .result
                                  .responseModel
                                  .isEmpty
                              ? const ErrorsWidget()
                              : ListView.separated(
                                  itemBuilder: (context, index) =>
                                      ShiftAllocationItem(
                                    item: ShiftAllocationCubit.get(context)
                                        .shiftAllocationModel
                                        .result
                                        .responseModel[index],
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 20,
                                  ),
                                  
                },
              )),
            ],
          ),
        ),
      ),
    );
  
 */