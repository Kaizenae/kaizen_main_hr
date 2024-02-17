import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../controller/attendance_cubit.dart';
import '../controller/attendance_state.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(AppPadding.p16.r),
          margin: EdgeInsets.symmetric(
              horizontal: AppPadding.p16.w, vertical: AppPadding.p12.h),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(AppSize.s10.r),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextCustom(
                      text: 'Date',
                      color: ColorManager.black,
                      fontSize: AppSize.s16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(
                      width: AppSize.s40,
                    ),
                    TextCustom(
                      text: 'Punch in',
                      color: ColorManager.primary,
                      fontSize: AppSize.s16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      width: AppSize.s10.w,
                    ),
                    TextCustom(
                      text: 'Punch out',
                      color: ColorManager.error,
                      fontSize: AppSize.s16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      width: AppSize.s10.w,
                    ),
                    TextCustom(
                      text: 'Hours',
                      color: ColorManager.secondary,
                      fontSize: AppSize.s16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const Divider(),
                BlocProvider.value(
                  value: BlocProvider.of<AttendanceCubit>(context)
                    ..getAttendanceFun(),
                  child: BlocConsumer<AttendanceCubit, AttendanceState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return state is GetAttendanceSuccess
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: AppPadding.p12.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextCustom(
                                      fontSize: FontSize.s14.sp,
                                      text: DateFormat('dd , MMM').format(
                                          DateTime.parse(state
                                              .attendanceEntity
                                              .resultEntity
                                              .response[index]
                                              .checkIn)),
                                      color: ColorManager.black,
                                    ),
                                    TextCustom(
                                      fontSize: FontSize.s14.sp,
                                      text: DateFormat('hh: mm a').format(
                                          DateTime.parse(state
                                              .attendanceEntity
                                              .resultEntity
                                              .response[index]
                                              .checkIn)),
                                      color: ColorManager.primary,
                                    ),
                                    TextCustom(
                                      fontSize: FontSize.s14.sp,
                                      text: state.attendanceEntity.resultEntity
                                                  .response[index].checkOut !=
                                              'false'
                                          ? DateFormat('hh: mm a').format(
                                              DateTime.tryParse(state
                                                  .attendanceEntity
                                                  .resultEntity
                                                  .response[index]
                                                  .checkOut)!)
                                          : '00: 00: 00',
                                      color: ColorManager.error,
                                    ),
                                    TextCustom(
                                      fontSize: FontSize.s14.sp,
                                      text: state.attendanceEntity.resultEntity
                                          .response[index].workedHours
                                          .toStringAsFixed(1),
                                      color: ColorManager.secondary,
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
                                    padding: EdgeInsets.symmetric(
                                        vertical: AppPadding.p12.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextCustom(
                                          fontSize: FontSize.s14.sp,
                                          text: '20 sep',
                                          color: ColorManager.black,
                                        ),
                                        TextCustom(
                                          fontSize: FontSize.s14.sp,
                                          text: '09:00 am',
                                          color: ColorManager.primary,
                                        ),
                                        TextCustom(
                                          fontSize: FontSize.s14.sp,
                                          text: '06:00 pm',
                                          color: ColorManager.error,
                                        ),
                                      ],
                                    ),
                                  ),
                                  itemCount: 10,
                                ))
                              : ErrorsWidget(
                                  onPress: () {
                                    BlocProvider.of<AttendanceCubit>(context)
                                        .getAttendanceFun();
                                  },
                                );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
