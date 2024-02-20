import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:Attendace/features/myTimeOff/presentation/controller/myTimeOff_cubit.dart';
import 'package:Attendace/features/myTimeOff/presentation/controller/myTimeOff_state.dart';
import 'package:Attendace/features/notifications/presentation/controllers/accept_reject_timeOff/accept_reject_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import 'userRequest_widget.dart';

class PendingTimeWidget extends StatelessWidget {
  const PendingTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MyTimeOffCubit>(context)..getAllTimeOffFun(),
      child: BlocConsumer<MyTimeOffCubit, MyTimeOffState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MyTimeOffCubit.get(context);

          return state is GetMyTimeOffSuccess
              ? ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: Column(
                      children: [
                        UserRequestWidget(
                          iconPath: IconsAssets.personIcon,
                          text: AppStrings.message,
                          subText: cubit.myTimeOffPending[index].employeeName,
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.emailIcon,
                          text: AppStrings.message,
                          subText: cubit.myTimeOffPending[index].holidayStatus,
                        ),
                        UserRequestWidget(
                            iconPath: IconsAssets.calenderIcon,
                            text: AppStrings.date,
                            subText: DateFormat('EEE, MMM dd, yyyy').format(
                                DateTime.parse(
                                    cubit.myTimeOffPending[index].start))),
                        UserRequestWidget(
                            iconPath: IconsAssets.calenderIcon,
                            text: AppStrings.date,
                            subText: DateFormat('EEE, MMM dd, yyyy').format(
                                DateTime.parse(
                                    cubit.myTimeOffPending[index].end))),
                        UserRequestWidget(
                          iconPath: IconsAssets.distanceIcon,
                          text: AppStrings.distance,
                          subText: cubit.myTimeOffPending[index].description,
                        ),
                        UserRequestWidget(
                            iconPath: IconsAssets.clockIcon,
                            text: AppStrings.status,
                            subText: cubit.myTimeOffPending[index].state),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                AcceptRejectTimeOffCubit.get(context).leavesId =
                                    cubit.myTimeOffPending[index].id;
                                AcceptRejectTimeOffCubit.get(context).states =
                                    'validate';

                                await AcceptRejectTimeOffCubit.get(context)
                                    .acceptRejectFun();
                                await cubit.getAllTimeOffFun();
                              },
                              child: const SvgPictureCustom(
                                assetsName: IconsAssets.acceptIcon,
                                color: null,
                                height: AppSize.s40,
                              ),
                            ),
                            InkWell(
                                onTap: () async {
                                  AcceptRejectTimeOffCubit.get(context)
                                          .leavesId =
                                      cubit.myTimeOffPending[index].id;
                                  AcceptRejectTimeOffCubit.get(context).states =
                                      'refuse';
                                  await AcceptRejectTimeOffCubit.get(context)
                                      .acceptRejectFun();
                                  await cubit.getAllTimeOffFun();
                                },
                                child: const SvgPictureCustom(
                                  assetsName: IconsAssets.rejectIcon,
                                  color: ColorManager.error,
                                  height: AppSize.s40,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  itemCount: cubit.myTimeOffPending.length,
                )
              : state is GetMyTimeOffLoading
                  ? ShimmerCustom(
                      child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Column(
                          children: List.generate(
                        6,
                        (index) => const UserRequestWidget(
                          iconPath: IconsAssets.emailIcon,
                          text: AppStrings.message,
                          subText: 'Loading.....',
                        ),
                      )),
                      itemCount: 2,
                    ))
                  : ErrorsWidget(
                      onPress: () {
                        cubit.getAllTimeOffFun();
                      },
                    );
        },
      ),
    );
  }
}
