// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:Attendace/core/utils/color_manager.dart';
import 'package:Attendace/core/utils/font_manager.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/features/attendance/presentation/screens/attendance_screen.dart';
import 'package:Attendace/features/check-in_check-out/presentation/check-in_check-out_screen.dart';
import 'package:Attendace/features/expenses/presentation/screens/screens/expenses_screen.dart';
import 'package:Attendace/features/home/presentation/controller/home_cubit.dart';
import 'package:Attendace/features/hr_policies/presentation/screens/hr_policies_screen.dart';
import 'package:Attendace/features/myTimeOff/presentation/screens/myTimeOff_screen.dart';
import 'package:Attendace/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:Attendace/features/overtime/presentation/screens/screens/overtime_screen.dart';
import 'package:Attendace/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/animation/slide_transtion.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../late_in_and_early_out/presentation/screens/late_in_and_early_out_screen.dart';
import '../../../myTimeOff/presentation/controller/myTimeOff_cubit.dart';
import '../../../myTimeOff/presentation/controller/myTimeOff_state.dart';
import '../../../notifications/presentation/controllers/requests_controller/bloc.dart';
import '../../../notifications/presentation/controllers/requests_controller/states.dart';
import '../../../profile/presentation/cubit/profile_cubit.dart';
import '../../../profile/presentation/cubit/profile_state.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../controller/home_state.dart';
import '../widget/feature_item_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldColor,
      body: BlocProvider.value(
        value: BlocProvider.of<HomeCubit>(context),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        child: Row(
                          children: [
                            const Image(
                              image: AssetImage(
                                ImageAssets.logoName,
                              ),
                              width: 150,
                            ),
                            const Spacer(),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                SvgPictureCustom(
                                  assetsName: IconsAssets.notificationIcon,
                                  color: ColorManager.grey1,
                                ),
                                Positioned(
                                    top: -10,
                                    left: 9,
                                    child:
                                        //  BlocBuilder<RequestsBloc,
                                        //     RequestsStates>(
                                        //   builder: (context, state) {
                                        //     return RequestsBloc.get(context)
                                        //             .pendingRequests
                                        //             .isNotEmpty
                                        //         ?
                                        Container(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: ColorManager.error,
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Text(
                                        // RequestsBloc.get(context)
                                        //             .pendingRequests
                                        //             .length >=
                                        //         100
                                        //     ?
                                        "+99"
                                        // : RequestsBloc.get(context)
                                        //     .pendingRequests
                                        //     .length
                                        //     .toString(),
                                        ,
                                        style: TextStyle(
                                            color: ColorManager.white,
                                            fontFamily:
                                                FontConstants.fontFamily,
                                            fontSize: FontSize.s14),
                                      ),
                                    )
                                    //       : const SizedBox();
                                    // },
                                    // ),
                                    ),
                              ],
                            ),

                            // AppConstants.admin
                            //     ? BlocProvider.value(
                            //         value:
                            //             BlocProvider.of<RequestsBloc>(context)
                            //               ..getRequests(),
                            //         child: IconButton(
                            //           onPressed: () {
                            //             Navigator.of(context).push(
                            //               SlideTranstion(
                            //                 page: const NotificationsScreen(),
                            //               ),
                            //             );
                            //           },
                            //           icon: Stack(
                            //             clipBehavior: Clip.none,
                            //             children: [
                            //               SvgPictureCustom(
                            //                 assetsName:
                            //                     IconsAssets.notificationIcon,
                            //                 color: ColorManager.grey1,
                            //               ),
                            //               Positioned(
                            //                 top: -10,
                            //                 left: 9,
                            //                 child: BlocBuilder<RequestsBloc,
                            //                     RequestsStates>(
                            //                   builder: (context, state) {
                            //                     return RequestsBloc.get(context)
                            //                             .pendingRequests
                            //                             .isNotEmpty
                            //                         ? Container(
                            //                             clipBehavior: Clip
                            //                                 .antiAliasWithSaveLayer,
                            //                             padding:
                            //                                 const EdgeInsets
                            //                                     .symmetric(
                            //                                     horizontal: 5),
                            //                             decoration:
                            //                                 BoxDecoration(
                            //                               borderRadius:
                            //                                   BorderRadius
                            //                                       .circular(8),
                            //                               color: ColorManager
                            //                                   .error,
                            //                               shape: BoxShape
                            //                                   .rectangle,
                            //                             ),
                            //                             child: Text(
                            //                               RequestsBloc.get(
                            //                                               context)
                            //                                           .pendingRequests
                            //                                           .length >=
                            //                                       100
                            //                                   ? "+99"
                            //                                   : RequestsBloc.get(
                            //                                           context)
                            //                                       .pendingRequests
                            //                                       .length
                            //                                       .toString(),
                            //                               style: TextStyle(
                            //                                   color:
                            //                                       ColorManager
                            //                                           .white,
                            //                                   fontFamily:
                            //                                       FontConstants
                            //                                           .fontFamily,
                            //                                   fontSize:
                            //                                       FontSize.s14),
                            //                             ),
                            //                           )
                            //                         : const SizedBox();
                            //                   },
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       )
                            //     : const SizedBox.shrink(),
                            const SizedBox(
                              width: 16,
                            ),
                            BlocProvider.value(
                              value: BlocProvider.of<ProfileCubit>(context)
                                ..getEmployeeFun(),
                              child: BlocBuilder<ProfileCubit, ProfileState>(
                                builder: (context, state) {
                                  return state is GetEmployeeSuccess
                                      ? state.employeeEntity.resultEntity
                                              .response[0].photo.isEmpty
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  SlideTranstion(
                                                    page: const ProfileScreen(),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: 55,
                                                height: 55,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  image: const DecorationImage(
                                                    image: AssetImage(
                                                      ImageAssets.userPhotoImg,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    SlideTranstion(
                                                        page:
                                                            const ProfileScreen()));
                                              },
                                              child: Container(
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                width: 55,
                                                height: 55,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: MemoryImage(
                                                      base64Decode(
                                                        state
                                                            .employeeEntity
                                                            .resultEntity
                                                            .response[0]
                                                            .photo,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                      : GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              SlideTranstion(
                                                page: const ProfileScreen(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 55,
                                            height: 55,
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: const DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                  ImageAssets.userPhotoImg,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        child: BlocProvider.value(
                          value: BlocProvider.of<ProfileCubit>(context)
                            ..getEmployeeFun(),
                          child: BlocBuilder<ProfileCubit, ProfileState>(
                              builder: (context, state) {
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "${AppStrings.welcome}, ${state is GetEmployeeSuccess ? state.employeeEntity.resultEntity.response[0].name.split(" ")[0] : ""}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                    ),
                                maxLines: 1,
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        child: Row(
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                AppStrings.myRemainingBalance,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: ColorManager.lightGrey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: FontSize.s14,
                                    ),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: BlocProvider.value(
                          value: BlocProvider.of<MyTimeOffCubit>(context)
                            ..getAllTimeOffValues(),
                          child: BlocBuilder<MyTimeOffCubit, MyTimeOffState>(
                            builder: (context, state) {
                              return SizedBox(
                                height: 130,
                                child: BlocProvider.of<MyTimeOffCubit>(context)
                                        .allTimeOffValueModel
                                        .result
                                        .responseModel
                                        .isNotEmpty
                                    ? ListView.separated(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                40,
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: ColorManager.lightGrey
                                                      .withOpacity(.5),
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 0),
                                                ),
                                              ],
                                              color: ColorManager.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSize.s16),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                TextCustom(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  text: BlocProvider.of<
                                                                  MyTimeOffCubit>(
                                                              context)
                                                          .allTimeOffNameAndValues[
                                                      index]["timeOffName"],
                                                  color: ColorManager.lightGrey,
                                                  fontSize: FontSize.s16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                Row(
                                                  children: [
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: TextCustom(
                                                        text: BlocProvider.of<
                                                                        MyTimeOffCubit>(
                                                                    context)
                                                                .allTimeOffNameAndValues[
                                                            index]["timeOffValue"],
                                                        color:
                                                            ColorManager.black,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                    // FittedBox(
                                                    //   fit: BoxFit.scaleDown,
                                                    //   child: TextCustom(
                                                    //     text: " /40.00",
                                                    //     color: ColorManager
                                                    //         .lightGrey,
                                                    //     fontSize: FontSize.s12,
                                                    //     fontWeight:
                                                    //         FontWeight.w500,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                                // FittedBox(
                                                //   fit: BoxFit.scaleDown,
                                                //   child: TextCustom(
                                                //     text: AppStrings.days,
                                                //     color:
                                                //         ColorManager.lightGrey,
                                                //     fontSize: FontSize.s14,
                                                //     fontWeight: FontWeight.w500,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            width: AppSize.s14,
                                          );
                                        },
                                        itemCount:
                                            BlocProvider.of<MyTimeOffCubit>(
                                                    context)
                                                .allTimeOffNameAndValues
                                                .length)
                                    : Center(
                                        child: Text(
                                          AppStrings.youDontHaveLeaveBalance,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        child: Row(
                          children: [
                            const Expanded(
                              child: FeatureItemWidget(
                                icon: ImageAssets.requests,
                                title: AppStrings.projects,
                                onTap: null,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: FeatureItemWidget(
                                onTap: () {
                                  Navigator.of(context).push(SlideTranstion(
                                      page: const ExpensesScreen()));
                                },
                                icon: ImageAssets.wallet,
                                title: AppStrings.expenses,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: FeatureItemWidget(
                                icon: ImageAssets.leaves,
                                title: AppStrings.myLeave,
                                onTap: () {
                                  Navigator.of(context).push(
                                    SlideTranstion(
                                      page: const MyTimeOffScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: FeatureItemWidget(
                                icon: ImageAssets.clock,
                                title: AppStrings.myLateIn,
                                onTap: () {
                                  Navigator.of(context).push(SlideTranstion(
                                    page: const LateInAndEarlyOutScreen(
                                      title: AppStrings.lateInRequest,
                                    ),
                                  ));
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: FeatureItemWidget(
                                onTap: () {
                                  Navigator.of(context).push(SlideTranstion(
                                    page: const LateInAndEarlyOutScreen(
                                      title: AppStrings.earlyOutRequest,
                                    ),
                                  ));
                                },
                                icon: ImageAssets.earlyOut,
                                title: AppStrings.myEarlyOut,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: FeatureItemWidget(
                                icon: ImageAssets.overTime,
                                onTap: () {
                                  Navigator.of(context).push(SlideTranstion(
                                      page: const OvertimeScreen()));
                                },
                                title: AppStrings.overTime,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      HomeCubit.get(context).isMore == true
                          ? Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FeatureItemWidget(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            SlideTranstion(
                                                page:
                                                    const AttendanceScreen()));
                                      },
                                      icon: ImageAssets.calendar,
                                      title: AppStrings.myAttendance,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),

                                  Expanded(
                                    child: FeatureItemWidget(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          SlideTranstion(
                                            page: const HrPoliciesScreen(),
                                          ),
                                        );
                                      },
                                      icon: ImageAssets.documentFile,
                                      title: AppStrings.hrPolices,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  // Expanded(
                                  //   child: FeatureItemWidget(
                                  //     icon: ImageAssets.shifts,
                                  //     onTap: () {
                                  //       Navigator.of(context).push(
                                  //         SlideTranstion(
                                  //           page: const ShiftAllocationScreen(),
                                  //         ),
                                  //       );
                                  //     },
                                  //     title: AppStrings.myShiftAllocation,
                                  //   ),
                                  // ),
                                  const Expanded(child: SizedBox())
                                ],
                              ),
                            )
                          : const SizedBox(),
                      HomeCubit.get(context).isMore == false
                          ? const SizedBox()
                          : const SizedBox(
                              height: 20,
                            ),
                      GestureDetector(
                        onTap: () {
                          HomeCubit.get(context).changeIsMore();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                            color: ColorManager.white,
                          ),
                          child: Row(
                            children: [
                              Text(
                                HomeCubit.get(context).isMore == false
                                    ? AppStrings.moreOption
                                    : AppStrings.lessOption,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorManager.lightGrey
                                          .withOpacity(.5),
                                      blurRadius: 5,
                                      offset: const Offset(0, 0),
                                    )
                                  ],
                                  color: ColorManager.darkPurple,
                                ),
                                child: Image(
                                  width: 22,
                                  image: AssetImage(
                                    HomeCubit.get(context).isMore == false
                                        ? ImageAssets.arrowDown
                                        : ImageAssets.arrowUp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.darkPurple,
        child: const Image(
          color: ColorManager.white,
          image: AssetImage(
            ImageAssets.fingerprint,
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(
            SlideTranstion(
              page: const CheckInCheckOutScreen(),
            ),
          );
        },
      ),
    );
  }
}
