import 'dart:developer';

import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../controllers/requests_controller/bloc.dart';
import '../controllers/requests_controller/states.dart';
import 'userRequest_widget.dart';

class PendingTimeWidget extends StatelessWidget {
  const PendingTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestsBloc()..getRequests(),
      child: BlocConsumer<RequestsBloc, RequestsStates>(
        listener: (context, state) {
          if (state is ApproveRequestSuccessState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.message.toString()),
              duration: Duration(
                seconds: AppConstants.snackBarTime,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            RequestsBloc.get(context).getRequests();
          } else if (state is ApproveRequestErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.message.toString()),
              duration: Duration(
                seconds: AppConstants.snackBarTime,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            RequestsBloc.get(context).getRequests();
          } else if (state is RejectRequestSuccessState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.message.toString()),
              duration: Duration(
                seconds: AppConstants.snackBarTime,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            RequestsBloc.get(context).getRequests();
          } else if (state is RejectRequestErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.message.toString()),
              duration: Duration(
                seconds: AppConstants.snackBarTime,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            RequestsBloc.get(context).getRequests();
          }
        },
        builder: (context, state) {
          log(state.toString());
          return state is RequestSuccessState &&
                  RequestsBloc.get(context)
                      .requestsModel
                      .result
                      .responseModel
                      .isNotEmpty
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
                          subText: RequestsBloc.get(context)
                              .requestsModel
                              .result
                              .responseModel[index]
                              .employeeName,
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.emailIcon,
                          text: AppStrings.message,
                          subText: RequestsBloc.get(context)
                              .requestsModel
                              .result
                              .responseModel[index]
                              .type,
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.emailIcon,
                          text: AppStrings.message,
                          subText: RequestsBloc.get(context)
                              .requestsModel
                              .result
                              .responseModel[index]
                              .reason,
                        ),
                        UserRequestWidget(
                            iconPath: IconsAssets.calenderIcon,
                            text: AppStrings.date,
                            subText: DateFormat('EEE, MMM dd, yyyy').format(
                                DateTime.parse(RequestsBloc.get(context)
                                    .requestsModel
                                    .result
                                    .responseModel[index]
                                    .startDate))),
                        UserRequestWidget(
                          iconPath: IconsAssets.calenderIcon,
                          text: AppStrings.date,
                          subText: DateFormat('EEE, MMM dd, yyyy').format(
                            DateTime.parse(
                              RequestsBloc.get(context)
                                  .requestsModel
                                  .result
                                  .responseModel[index]
                                  .endDate,
                            ),
                          ),
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.clockIcon,
                          text: AppStrings.duration,
                          subText: RequestsBloc.get(context)
                              .requestsModel
                              .result
                              .responseModel[index]
                              .duration
                              .toString(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                RequestsBloc.get(context).approveRequest(
                                    requestId: RequestsBloc.get(context)
                                        .requestsModel
                                        .result
                                        .responseModel[index]
                                        .id,
                                    type: RequestsBloc.get(context)
                                        .requestsModel
                                        .result
                                        .responseModel[index]
                                        .type);
                              },
                              child: const SvgPictureCustom(
                                assetsName: IconsAssets.acceptIcon,
                                color: null,
                                height: AppSize.s40,
                              ),
                            ),
                            InkWell(
                                onTap: () async {
                                  RequestsBloc.get(context).rejectRequest(
                                      requestId: RequestsBloc.get(context)
                                          .requestsModel
                                          .result
                                          .responseModel[index]
                                          .id,
                                      type: RequestsBloc.get(context)
                                          .requestsModel
                                          .result
                                          .responseModel[index]
                                          .type);
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
                  itemCount: RequestsBloc.get(context)
                      .requestsModel
                      .result
                      .responseModel
                      .length,
                )
              : state is RequestLoadingState
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
                      onPress: () {},
                    );
        },
      ),
    );
  }
}
