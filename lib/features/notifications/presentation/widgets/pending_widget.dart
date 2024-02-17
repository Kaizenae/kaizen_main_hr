import 'package:Attendace/core/utils/media_query_values.dart';
import 'package:Attendace/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:Attendace/core/widgets/svg_pic/svg_pic.dart';
import 'package:Attendace/core/widgets/text_custom/text_custom.dart';
import 'package:Attendace/features/myRequests/presentation/controller/myRequests_cubit.dart';
import 'package:Attendace/features/myRequests/presentation/controller/myRequests_state.dart';
import 'package:Attendace/features/notifications/presentation/controllers/accept_reject_request/accept_reject_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import 'userRequest_widget.dart';

class PendingWidget extends StatelessWidget {
  const PendingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MyRequestsCubit>(context)
        ..getMyRequestsPendingFun(),
      child: BlocConsumer<MyRequestsCubit, MyRequestsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MyRequestsCubit.get(context);
          return state is GetMyRequestsPendingSuccess
              ? ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(AppPadding.p12.r),
                    child: Column(
                      children: [
                        UserRequestWidget(
                          iconPath: IconsAssets.personIcon,
                          text: AppStrings.message,
                          subText: state.myRequestsEntity.resultEntity
                              .response[index].employeeName,
                        ),
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
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        ElevatedButtonCustom(
                          fontSize: FontSize.s14.sp,
                          onPressed: () async {
                            await cubit.launchInBrowser(Uri.parse(state
                                .myRequestsEntity
                                .resultEntity
                                .response[index]
                                .location
                                .trim()));
                          },
                          width: context.width / 1.6,
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SvgPictureCustom(
                                assetsName: IconsAssets.locationIcon,
                                color: ColorManager.white,
                              ),
                              SizedBox(
                                width: AppSize.s10.w,
                              ),
                              TextCustom(
                                text: AppStrings.location,
                                color: ColorManager.white,
                                fontSize: AppSize.s18.sp,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                AcceptRejectRequestCubit.get(context).playerId =
                                    state.myRequestsEntity.resultEntity
                                        .response[index].noId;
                                AcceptRejectRequestCubit.get(context).id = state
                                    .myRequestsEntity
                                    .resultEntity
                                    .response[index]
                                    .id;
                                AcceptRejectRequestCubit.get(context).isAccept =
                                    1;
                                AcceptRejectRequestCubit.get(context).states =
                                    'done';
                                AcceptRejectRequestCubit.get(context)
                                    .acceptRejectFun();

                                cubit.userId = '';
                                cubit.getMyRequestsPendingFun();
                              },
                              child: SvgPictureCustom(
                                assetsName: IconsAssets.acceptIcon,
                                color: null,
                                height: AppSize.s40.h,
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  AcceptRejectRequestCubit.get(context).id =
                                      state.myRequestsEntity.resultEntity
                                          .response[index].id;
                                  AcceptRejectRequestCubit.get(context)
                                      .isAccept = 0;
                                  AcceptRejectRequestCubit.get(context).states =
                                      'reject';
                                  AcceptRejectRequestCubit.get(context)
                                      .acceptRejectFun();
                                  cubit.userId = '';
                                  cubit.getMyRequestsPendingFun();
                                },
                                child: SvgPictureCustom(
                                  assetsName: IconsAssets.rejectIcon,
                                  color: ColorManager.error,
                                  height: AppSize.s40.h,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  itemCount:
                      state.myRequestsEntity.resultEntity.response.length,
                )
              : state is GetMyRequestsPendingLoading
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
                        cubit.getMyRequestsPendingFun();
                      },
                    );
        },
      ),
    );
  }
}
