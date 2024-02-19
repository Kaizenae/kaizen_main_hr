import 'package:Attendace/core/utils/color_manager.dart';
import 'package:Attendace/core/utils/routes_manager.dart';
import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
import 'package:Attendace/core/widgets/component.dart';
import 'package:Attendace/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:flutter_screenutil/flutter_screenutil.dart';
=======
>>>>>>> main

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';

import 'package:flutter/material.dart';

import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../attendance/presentation/controller/attendance_cubit.dart';
import '../../../myRequests/presentation/controller/myRequests_cubit.dart';
import '../../../myRequests/presentation/widgets/userRequest_widget.dart';
import '../cubit/all_employees_cubit.dart';
import '../cubit/all_employees_state.dart';

class AllEmployeesScreen extends StatelessWidget {
  const AllEmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        appBarCustom: const AppBarCustom(
          text: AppStrings.employees,
          isNull: false,
        ),
        body: BlocProvider.value(
          value: BlocProvider.of<AllEmployeesCubit>(context)..getEmployeesFun(),
          child: BlocConsumer<AllEmployeesCubit, AllEmployeesState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubitProfile = ProfileCubit.get(context);
              var cubitAttendance = BlocProvider.of<AttendanceCubit>(context);
              var cubitMyRequests = MyRequestsCubit.get(context);
              return state is GetEmployeesSuccess
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
<<<<<<< HEAD
                        padding: EdgeInsets.all(
                          AppPadding.p16.r,
=======
                        padding: const EdgeInsets.all(
                          AppPadding.p16,
>>>>>>> main
                        ),
                        child: InkWell(
                          onTap: () {
                            cubitProfile.userId = state
                                .employeeEntity.resultEntity.response[index].id;
                            cubitAttendance.userId = state
                                .employeeEntity.resultEntity.response[index].id;
                            cubitMyRequests.userId = state
                                .employeeEntity.resultEntity.response[index].id;
                            navigator(context, Routes.employeeRoute);
                          },
                          child: BounceInLeft(
                            child: Container(
<<<<<<< HEAD
                              padding: EdgeInsets.all(AppPadding.p12.r),
                              decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(AppSize.s10.r),
                                    bottomRight: Radius.circular(AppSize.s10.r),
=======
                              padding: const EdgeInsets.all(AppPadding.p12),
                              decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(AppSize.s10),
                                    bottomRight: Radius.circular(AppSize.s10),
>>>>>>> main
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(-3, 3),
                                        color: Colors.grey.shade200,
                                        blurRadius: 1)
                                  ]),
                              child: Column(
                                children: [
                                  UserRequestWidget(
                                    iconPath: IconsAssets.personIcon,
                                    text: AppStrings.message,
                                    subText: state.employeeEntity.resultEntity
                                        .response[index].name,
                                  ),
<<<<<<< HEAD
                                  SizedBox(
                                    height: AppSize.s10.h,
=======
                                  const SizedBox(
                                    height: AppSize.s10,
>>>>>>> main
                                  ),
                                  UserRequestWidget(
                                    iconPath: IconsAssets.emailIcon,
                                    text: AppStrings.message,
                                    subText: state.employeeEntity.resultEntity
                                        .response[index].email,
                                  ),
<<<<<<< HEAD
                                  SizedBox(
                                    height: AppSize.s10.h,
=======
                                  const SizedBox(
                                    height: AppSize.s10,
>>>>>>> main
                                  ),
                                  UserRequestWidget(
                                    iconPath: IconsAssets.phoneIcon,
                                    text: AppStrings.phone,
                                    subText: state.employeeEntity.resultEntity
                                        .response[index].mobilePhone
                                        .toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      itemCount:
                          state.employeeEntity.resultEntity.response.length,
                    )
                  : state is GetEmployeesLoading
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
                                subText: '100000 M',
                              ),
                              UserRequestWidget(
                                iconPath: IconsAssets.clockIcon,
                                text: AppStrings.status,
                                subText: ' ',
                              ),
                            ],
                          ),
                          itemCount: 5,
                        ))
                      : ErrorsWidget(
                          onPress: () {
                            BlocProvider.of<AllEmployeesCubit>(context)
                                .getEmployeesFun();
                          },
                        );
            },
          ),
        ));
  }
}
