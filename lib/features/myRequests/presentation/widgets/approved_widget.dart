import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:Attendace/features/myRequests/presentation/controller/myRequests_cubit.dart';
import 'package:Attendace/features/myRequests/presentation/controller/myRequests_state.dart';
import 'package:Attendace/features/notifications/presentation/controllers/accept_reject_request/accept_reject_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import 'userRequest_widget.dart';

class ApprovedWidget extends StatelessWidget {
  const ApprovedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MyRequestsCubit>(context)..getMyRequestsFun(),
      child: BlocConsumer<MyRequestsCubit, MyRequestsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return state is GetMyRequestsSuccess
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
              : state is GetMyRequestsLoading
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
                            .getMyRequestsFun();
                      },
                    );
        },
      ),
    );
  }
}
