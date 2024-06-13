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

class AllAtendanceScreen extends StatelessWidget {
  const AllAtendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      body: SafeArea(
        child: BlocProvider.value(
          value: BlocProvider.of<AttendanceCubit>(context)..getAttendanceFun(),
          child: BlocBuilder<AttendanceCubit, AttendanceState>(
            builder: (context, state) {
              return state is GetAttendanceSuccess
                  ? state.attendanceEntity.resultEntity.response.isEmpty
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
                                    color:
                                        ColorManager.lightGrey.withOpacity(.1),
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
                                        flex: 3,
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
                                                state
                                                            .attendanceEntity
                                                            .resultEntity
                                                            .response[index]
                                                            .checkIn !=
                                                        ''
                                                    ? DateFormat("dd,MMM,yyyy")
                                                        .format(DateTime.parse(
                                                            state
                                                                .attendanceEntity
                                                                .resultEntity
                                                                .response[index]
                                                                .checkIn))
                                                    : DateFormat("dd,MMM,yyyy")
                                                        .format(
                                                        DateTime.parse(
                                                          state
                                                              .attendanceEntity
                                                              .resultEntity
                                                              .response[index]
                                                              .checkOut,
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
                                        width: 5,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                "${state.attendanceEntity.resultEntity.response[index].workedHours.floor().toString()}:${(double.parse(".${state.attendanceEntity.resultEntity.response[index].workedHours.toString().split(".").last}") * 60).round()}",
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
                                        flex: 3,
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
                                                state
                                                            .attendanceEntity
                                                            .resultEntity
                                                            .response[index]
                                                            .checkIn !=
                                                        ''
                                                    ? DateFormat('hh: mm a')
                                                        .format(
                                                        DateTime.parse(state
                                                                .attendanceEntity
                                                                .resultEntity
                                                                .response[index]
                                                                .checkIn)
                                                            .add(
                                                          const Duration(
                                                            hours: 3,
                                                          ),
                                                        ),
                                                      )
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
                                        width: 5,
                                      ),
                                      Expanded(
                                        flex: 2,
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
                                                state
                                                            .attendanceEntity
                                                            .resultEntity
                                                            .response[index]
                                                            .checkOut !=
                                                        ''
                                                    ? DateFormat('hh: mm a')
                                                        .format(
                                                        DateTime.tryParse(state
                                                                .attendanceEntity
                                                                .resultEntity
                                                                .response[index]
                                                                .checkOut)!
                                                            .add(
                                                          const Duration(
                                                            hours: 3,
                                                          ),
                                                        ),
                                                      ) // we need add duration about 3 hours to set time in UAE becuse we recive time in UTC time zone
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
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemCount: state
                              .attendanceEntity.resultEntity.response.length,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                              '00: 00',
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
                          ),
                          itemCount: 10,
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            height: 20,
                          ),
                        ))
                      : const ErrorsWidget();
            },
          ),
        ),
      ),
    );
  }
}


/*
 Container(
          padding: const EdgeInsets.all(AppPadding.p12),
          margin: const EdgeInsets.symmetric(
              horizontal: AppPadding.p16, vertical: AppPadding.p12),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(AppSize.s10),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const Row(
                  children: [
                    
                BlocProvider.value(
                  value: BlocProvider.of<AttendanceCubit>(context)
                    ..getAttendanceFun(),
                  child: BlocConsumer<AttendanceCubit, AttendanceState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return state is GetAttendanceSuccess
                          ? state.attendanceEntity.resultEntity.response.isEmpty
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
                                              text: state
                                                          .attendanceEntity
                                                          .resultEntity
                                                          .response[index]
                                                          .checkIn !=
                                                      ''
                                                  ? DateFormat("dd,MMM,yyyy")
                                                      .format(DateTime.parse(
                                                          state
                                                              .attendanceEntity
                                                              .resultEntity
                                                              .response[index]
                                                              .checkIn))
                                                  : DateFormat("dd,MMM,yyyy")
                                                      .format(DateTime.parse(
                                                          state
                                                              .attendanceEntity
                                                              .resultEntity
                                                              .response[index]
                                                              .checkOut)),
                                              color: ColorManager.black,
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
                                              text: state
                                                          .attendanceEntity
                                                          .resultEntity
                                                          .response[index]
                                                          .checkIn !=
                                                      ''
                                                  ? DateFormat('hh: mm a').format(
                                                      DateTime.parse(state
                                                              .attendanceEntity
                                                              .resultEntity
                                                              .response[index]
                                                              .checkIn)
                                                          .add(const Duration(
                                                              hours: 4)))
                                                  : '00: 00: 00', // we need add duration about 4 hours to set time in UAE becuse we recive time in UTC time zone
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
                                              text: state
                                                          .attendanceEntity
                                                          .resultEntity
                                                          .response[index]
                                                          .checkOut !=
                                                      ''
                                                  ? DateFormat('hh: mm a').format(
                                                      DateTime.tryParse(state
                                                              .attendanceEntity
                                                              .resultEntity
                                                              .response[index]
                                                              .checkOut)!
                                                          .add(const Duration(
                                                              hours:
                                                                  4))) // we need add duration about 4 hours to set time in UAE becuse we recive time in UTC time zone
                                                  : '00: 00: 00',
                                              color: ColorManager.primary,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: TextCustom(
                                              fontSize: FontSize.s14,
                                              text:
                                                  "${state.attendanceEntity.resultEntity.response[index].workedHours.floor().toString()}:${(double.parse(".${state.attendanceEntity.resultEntity.response[index].workedHours.toString().split(".").last}") * 60).round()}",
                                              color: ColorManager.error,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  itemCount: state.attendanceEntity.resultEntity
                                      .response.length,
                                )
                          : state is GetAttendanceLoading
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
                                ))
                              : const ErrorsWidget();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
     
*/