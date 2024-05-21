// ignore_for_file: deprecated_member_use

import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:Attendace/features/myTimeOff/presentation/controller/myTimeOff_cubit.dart';
import 'package:Attendace/features/myTimeOff/presentation/controller/myTimeOff_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import 'userRequest_widget.dart';

class RefusedWidget extends StatelessWidget {
  const RefusedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MyTimeOffCubit>(context)..getMyTimeOffFun(),
      child: BlocConsumer<MyTimeOffCubit, MyTimeOffState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MyTimeOffCubit.get(context);

          return cubit.myTimeOffRefuse.isNotEmpty
              ? ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserRequestWidget(
                          iconPath: IconsAssets.emailIcon,
                          text: AppStrings.message,
                          subText: cubit.myTimeOffRefuse[index].holidayStatus,
                        ),
                        UserRequestWidget(
                            iconPath: IconsAssets.calenderIcon,
                            text: AppStrings.date,
                            subText: DateFormat('EEE, MMM dd, yyyy').format(
                                DateTime.parse(
                                    cubit.myTimeOffRefuse[index].start))),
                        UserRequestWidget(
                            iconPath: IconsAssets.calenderIcon,
                            text: AppStrings.date,
                            subText: DateFormat('EEE, MMM dd, yyyy').format(
                                DateTime.parse(
                                    cubit.myTimeOffRefuse[index].end))),
                        UserRequestWidget(
                          iconPath: IconsAssets.distanceIcon,
                          text: AppStrings.distance,
                          subText: cubit.myTimeOffRefuse[index].description,
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.clockIcon,
                          text: AppStrings.status,
                          subText: cubit.myTimeOffRefuse[index].state,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        cubit.myTimeOffRefuse[index].approvers.isNotEmpty
                            ? Text(
                                AppStrings.approvers,
                                style: TextStyle(
                                  fontFamily: FontConstants.fontFamily,
                                  color: ColorManager.black,
                                  fontSize: FontSize.s18,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : const SizedBox(),
                        cubit.myTimeOffRefuse[index].approvers.isNotEmpty
                            ? const SizedBox(
                                height: 10,
                              )
                            : const SizedBox(),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, ind) => Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                IconsAssets.personIcon,
                                                height: AppSize.s24,
                                                color: ColorManager.skyColor,
                                              ),
                                              const SizedBox(
                                                width: AppSize.s8,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  cubit.myTimeOffRefuse[index]
                                                      .approvers[ind].userName,
                                                  style: TextStyle(
                                                    fontFamily: FontConstants
                                                        .fontFamily,
                                                    color: ColorManager.primary,
                                                    fontSize: FontSize.s16,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                cubit.myTimeOffRefuse[index]
                                                    .approvers[ind].state,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FontConstants.fontFamily,
                                                  color: ColorManager.primary,
                                                  fontSize: FontSize.s14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            cubit.myTimeOffRefuse[index]
                                                .approvers[ind].reason,
                                            style: TextStyle(
                                              fontFamily:
                                                  FontConstants.fontFamily,
                                              fontSize: FontSize.s14,
                                              color: ColorManager.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            itemCount:
                                cubit.myTimeOffRefuse[index].approvers.length),
                      ],
                    ),
                  ),
                  itemCount: cubit.myTimeOffRefuse.length,
                )
              : state is GetMyTimeOffLoading
                  ? ShimmerCustom(
                      child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => const Column(
                        children: [
                          UserRequestWidget(
                            iconPath: IconsAssets.emailIcon,
                            text: AppStrings.message,
                            subText: 'Loading.....',
                          ),
                          UserRequestWidget(
                            iconPath: IconsAssets.clockIcon,
                            text: AppStrings.status,
                            subText: 'Loading.....',
                          ),
                        ],
                      ),
                      itemCount: 2,
                    ))
                  : ErrorsWidget(
                      onPress: () {
                        cubit.getMyTimeOffFun();
                      },
                    );
        },
      ),
    );
  }
}
