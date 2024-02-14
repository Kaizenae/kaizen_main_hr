import 'dart:io';

import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:Attendace/features/myRequests/presentation/controller/myRequests_cubit.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../../core/widgets/tab_bar_custom/tab_bar_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../attendance/presentation/controller/attendance_cubit.dart';
import '../../../attendance/presentation/controller/attendance_state.dart';
import '../../../myLoans/presentation/widgets/userRequest_widget.dart';
import '../../../myRequests/presentation/controller/myRequests_state.dart';
import '../../../notifications/presentation/controllers/accept_reject_request/accept_reject_request_cubit.dart';
import '../../../profile/presentation/cubit/profile_cubit.dart';
import '../../../profile/presentation/cubit/profile_state.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        appBarCustom: const AppBarCustom(),
        body: Padding(
          padding: EdgeInsets.all(AppPadding.p16.r),
          child: SafeArea(
            child: Column(
              children: [
                Center(
                  child: BlocProvider.value(
                    value: BlocProvider.of<ProfileCubit>(context)
                      ..getEmployeeFun(),
                    child: BlocConsumer<ProfileCubit, ProfileState>(
                      listener: (context, state) {
                        if (state is GetEmployeeError) {
                          showToast(
                              message: state.message,
                              color: ColorManager.error);
                        }
                      },
                      builder: (context, state) {
                        return state is GetEmployeeSuccess
                            ? Column(
                                children: [
                                  TextCustom(
                                    text: state.employeeEntity.resultEntity
                                        .response[0].name,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.s22.sp,
                                    color: ColorManager.black,
                                  ),
                                  SizedBox(
                                    height: AppSize.s16.h,
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.all(AppPadding.p8 / 2)
                                            .r,
                                    decoration: BoxDecoration(
                                        color: ColorManager.textBackgroundColor,
                                        borderRadius: BorderRadius.circular(
                                            AppSize.s10.r)),
                                    child: TextCustom(
                                      text: state.employeeEntity.resultEntity
                                          .response[0].email,
                                      fontSize: FontSize.s12.sp,
                                      color: ColorManager.grey2,
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppSize.s20.sp,
                                  ),
                                  TextCustom(
                                    text: state.employeeEntity.resultEntity
                                        .response[0].mobilePhone,
                                    fontSize: FontSize.s12.sp,
                                    color: ColorManager.primary,
                                  ),
                                ],
                              )
                            : state is GetEmployeeLoading
                                ? ShimmerCustom(
                                    child: Column(
                                    children: [
                                      TextCustom(
                                        text: 'Kaizen',
                                        fontWeight: FontWeight.w600,
                                        fontSize: FontSize.s22.sp,
                                        color: ColorManager.black,
                                      ),
                                      SizedBox(
                                        height: AppSize.s16.h,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(
                                                AppPadding.p8 / 2)
                                            .r,
                                        decoration: BoxDecoration(
                                            color: ColorManager
                                                .textBackgroundColor,
                                            borderRadius: BorderRadius.circular(
                                                AppSize.s10.r)),
                                        child: TextCustom(
                                          text: 'xxx@xx.com',
                                          fontSize: FontSize.s12.sp,
                                          color: ColorManager.grey2,
                                        ),
                                      ),
                                      SizedBox(
                                        height: AppSize.s20.h,
                                      ),
                                      TextCustom(
                                        text: '+201000000000',
                                        fontSize: FontSize.s12.sp,
                                        color: ColorManager.primary,
                                      ),
                                    ],
                                  ))
                                : const ErrorsWidget();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Platform.isAndroid
                    ? TabBarCustom(
                        onTap: (v) {
                          if (v == 0) {
                            BlocProvider.of<AttendanceCubit>(context)
                                .getEmployeeAttendanceFun();
                          } else if (v == 1) {
                            BlocProvider.of<MyRequestsCubit>(context)
                                .getEmployeeRequestsFun();
                          }
                        },
                        widgets: const [
                          EmployeeAttendance(),
                          EmployeeRequests(),
                        ],
                        myTabs: const [
                          Tab(
                            text: AppStrings.attendance,
                          ),
                          Tab(
                            text: AppStrings.requests,
                          )
                        ],
                      )
                    : Expanded(
                        child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: <Widget>[
                              ButtonsTabBar(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p12),
                                backgroundColor: ColorManager.primary,
                                unselectedBackgroundColor: Colors.grey[300],
                                unselectedLabelStyle:
                                    const TextStyle(color: Colors.black),
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSize.s20),
                                tabs: const [
                                  Tab(
                                    // icon: Icon(Icons.directions_car),
                                    text: AppStrings.approved,
                                  ),
                                  Tab(
                                    // icon: Icon(Icons.directions_transit),
                                    text: AppStrings.pending,
                                  ),
                                ],
                              ),
                              const Expanded(
                                child: TabBarView(
                                  children: <Widget>[
                                    EmployeeAttendance(),
                                    EmployeeRequests(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ));
  }
}

class EmployeeAttendance extends StatelessWidget {
  const EmployeeAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AttendanceCubit>(context)
        ..getEmployeeAttendanceFun(),
      child: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {},
        builder: (context, state) {
          return state is GetEmployeeAttendanceSuccess
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: AppPadding.p12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextCustom(
                          text: DateFormat('dd , MMM').format(DateTime.parse(
                              state.attendanceEntity.resultEntity
                                  .response[index].checkIn)),
                          color: ColorManager.black,
                        ),
                        TextCustom(
                          text: DateFormat('hh: mm a').format(DateTime.parse(
                              state.attendanceEntity.resultEntity
                                  .response[index].checkIn)),
                          color: ColorManager.primary,
                        ),
                        TextCustom(
                          text: state.attendanceEntity.resultEntity
                                      .response[index].checkOut !=
                                  'false'
                              ? DateFormat('hh: mm a').format(DateTime.parse(
                                  state.attendanceEntity.resultEntity
                                      .response[index].checkOut))
                              : '00: 00: 00',
                          color: ColorManager.error,
                        ),
                        TextCustom(
                          text: state.attendanceEntity.resultEntity
                              .response[index].workedHours
                              .toStringAsFixed(1),
                          color: ColorManager.secondary,
                        ),
                      ],
                    ),
                  ),
                  itemCount:
                      state.attendanceEntity.resultEntity.response.length,
                )
              : state is GetEmployeeAttendanceLoading
                  ? ShimmerCustom(
                      child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: AppPadding.p8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextCustom(
                              text: '20 sep',
                              color: ColorManager.black,
                            ),
                            const TextCustom(
                              text: '09 am       ',
                              color: ColorManager.primary,
                            ),
                            TextCustom(
                              text: '06 pm     ',
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
    );
  }
}

class EmployeeRequests extends StatelessWidget {
  const EmployeeRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MyRequestsCubit>(context)
        ..getEmployeeRequestsFun(),
      child: BlocConsumer<MyRequestsCubit, MyRequestsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return state is GetEmployeeRequestsSuccess
              ? ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(AppPadding.p12.r),
                    child: Column(
                      children: [
                        UserRequestWidget(
                          iconPath: IconsAssets.emailIcon,
                          text: AppStrings.message,
                          subText: state.myRequestsEntity.resultEntity
                              .response[index].message,
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.calenderIcon,
                          text: AppStrings.date,
                          subText:
                              '${DateFormat('EEE, MMM dd, yyyy').format(DateTime.parse(state.myRequestsEntity.resultEntity.response[index].date))} - ${DateFormat('hh: mm aa').format(DateTime.parse(state.myRequestsEntity.resultEntity.response[index].date))}',
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.distanceIcon,
                          text: AppStrings.distance,
                          subText:
                              '${state.myRequestsEntity.resultEntity.response[index].distance} meters away',
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.clockIcon,
                          text: AppStrings.status,
                          subText: AcceptRejectRequestCubit.get(context)
                              .stateFun(state.myRequestsEntity.resultEntity
                                  .response[index].state),
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.keyIcon,
                          text: AppStrings.type,
                          subText: AcceptRejectRequestCubit.get(context)
                              .typeFun(state.myRequestsEntity.resultEntity
                                  .response[index].checkType),
                        ),
                      ],
                    ),
                  ),
                  itemCount:
                      state.myRequestsEntity.resultEntity.response.length,
                )
              : state is GetEmployeeRequestsLoading
                  ? ShimmerCustom(
                      child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => const Column(
                        children: [
                          UserRequestWidget(
                            iconPath: IconsAssets.emailIcon,
                            text: AppStrings.message,
                            subText: '',
                          ),
                          UserRequestWidget(
                            iconPath: IconsAssets.calenderIcon,
                            text: AppStrings.date,
                            subText: '',
                          ),
                          UserRequestWidget(
                            iconPath: IconsAssets.clockIcon,
                            text: AppStrings.time,
                            subText: '',
                          ),
                          UserRequestWidget(
                            iconPath: IconsAssets.distanceIcon,
                            text: AppStrings.distance,
                            subText: ' M',
                          ),
                          UserRequestWidget(
                            iconPath: IconsAssets.clockIcon,
                            text: AppStrings.status,
                            subText: ' ',
                          ),
                        ],
                      ),
                      itemCount: 2,
                    ))
                  : ErrorsWidget(
                      onPress: () {
                        BlocProvider.of<MyRequestsCubit>(context)
                            .getEmployeeRequestsFun();
                      },
                    );
        },
      ),
    );
  }
}
