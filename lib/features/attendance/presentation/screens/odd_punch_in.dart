// ignore_for_file: unrelated_type_equality_checks

import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../controller/attendance_cubit.dart';
import '../controller/attendance_state.dart';

class OddPunshInScreen extends StatelessWidget {
  const OddPunshInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      body: SafeArea(
          child: BlocProvider.value(
        value: BlocProvider.of<AttendanceCubit>(context)..getOddPunch(),
        child: BlocBuilder<AttendanceCubit, AttendanceState>(
            builder: (context, state) {
          return state is GetOddPunchSuccessState
              ? AttendanceCubit.get(context)
                      .oddPunchModel
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
                                      AttendanceCubit.get(context)
                                                  .oddPunchModel
                                                  .result
                                                  .responseModel[index]
                                                  .checkIn !=
                                              ""
                                          ? DateFormat("dd,MMM,yyyy").format(
                                              DateTime.parse(
                                                  AttendanceCubit.get(context)
                                                      .oddPunchModel
                                                      .result
                                                      .responseModel[index]
                                                      .checkIn))
                                          : DateFormat("dd,MMM,yyyy").format(
                                              DateTime.parse(
                                                  AttendanceCubit.get(context)
                                                      .oddPunchModel
                                                      .result
                                                      .responseModel[index]
                                                      .checkOut)),
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
                                            AttendanceCubit.get(context)
                                                        .oddPunchModel
                                                        .result
                                                        .responseModel[index]
                                                        .checkIn !=
                                                    ""
                                                ? DateFormat('hh: mm a').format(
                                                    DateTime.parse(
                                                            AttendanceCubit.get(
                                                                    context)
                                                                .oddPunchModel
                                                                .result
                                                                .responseModel[
                                                                    index]
                                                                .checkIn)
                                                        .add(const Duration(
                                                            hours: 4)))
                                                : '00: 00',
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
                                            AttendanceCubit.get(context)
                                                        .oddPunchModel
                                                        .result
                                                        .responseModel[index]
                                                        .checkOut !=
                                                    ""
                                                ? DateFormat('hh: mm a').format(
                                                    DateTime.parse(
                                                            AttendanceCubit.get(
                                                                    context)
                                                                .oddPunchModel
                                                                .result
                                                                .responseModel[
                                                                    index]
                                                                .checkOut)
                                                        .add(const Duration(
                                                            hours:
                                                                4))) // we need add duration about 4 hours to set time in UAE becuse we recive time in UTC time zone
                                                : '00: 00',
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
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                      itemCount: AttendanceCubit.get(context)
                          .oddPunchModel
                          .result
                          .responseModel
                          .length,
                    )
              : state is GetAttendanceLoading
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
                  : const ErrorsWidget();
        }),
      )),
    );
  }
}

/*

                BlocProvider.value(
                  value: BlocProvider.of<AttendanceCubit>(context)
                    ..getOddPunch(),
                  child: BlocConsumer<AttendanceCubit, AttendanceState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return state is GetOddPunchSuccessState
                          ? AttendanceCubit.get(context)
                                  .oddPunchModel
                                  .result
                                  .responseModel
                                  .isEmpty
                              ? const ErrorsWidget()
                              : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: AppPadding.p12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: TextCustom(
                                              fontSize: FontSize.s14,
                                              text: AttendanceCubit.get(context)
                                                          .oddPunchModel
                                                          .result
                                                          .responseModel[index]
                                                          .checkIn !=
                                                      ""
                                                  ? DateFormat("dd,MMM,yyyy")
                                                      .format(DateTime.parse(
                                                          AttendanceCubit.get(context)
                                                              .oddPunchModel
                                                              .result
                                                              .responseModel[
                                                                  index]
                                                              .checkIn))
                                                  : DateFormat("dd,MMM,yyyy")
                                                      .format(DateTime.parse(
                                                          AttendanceCubit.get(context)
                                                              .oddPunchModel
                                                              .result
                                                              .responseModel[index]
                                                              .checkOut)),
                                              color: ColorManager.black,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: TextCustom(
                                              fontSize: FontSize.s14,
                                              text: AttendanceCubit.get(context)
                                                          .oddPunchModel
                                                          .result
                                                          .responseModel[index]
                                                          .checkIn !=
                                                      ""
                                                  ? DateFormat('hh: mm a')
                                                      .format(DateTime.parse(
                                                              AttendanceCubit.get(
                                                                      context)
                                                                  .oddPunchModel
                                                                  .result
                                                                  .responseModel[
                                                                      index]
                                                                  .checkIn)
                                                          .add(const Duration(
                                                              hours: 4)))
                                                  : '00: 00: 00', // we need add duration about 4 hours to set time in UAE becuse we recive time in UTC time zone
                                              color: ColorManager.primary,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: TextCustom(
                                              fontSize: FontSize.s14,
                                              text: AttendanceCubit.get(context)
                                                          .oddPunchModel
                                                          .result
                                                          .responseModel[index]
                                                          .checkOut !=
                                                      ""
                                                  ? DateFormat('hh: mm a')
                                                      .format(DateTime.parse(
                                                              AttendanceCubit.get(
                                                                      context)
                                                                  .oddPunchModel
                                                                  .result
                                                                  .responseModel[
                                                                      index]
                                                                  .checkOut)
                                                          .add(const Duration(
                                                              hours:
                                                                  4))) // we need add duration about 4 hours to set time in UAE becuse we recive time in UTC time zone
                                                  : '00: 00: 00',
                                              color: ColorManager.primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  itemCount: AttendanceCubit.get(context)
                                      .oddPunchModel
                                      .result
                                      .responseModel
                                      .length,
                                )
                          : state is GetOddPunchLoadingState
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
                              : const ErrorsWidget();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
     
 */
