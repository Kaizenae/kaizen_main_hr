// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../controllers/requests_controller/bloc.dart';
import '../controllers/requests_controller/states.dart';
import 'userRequest_widget.dart';

class PendingRequestsWidget extends StatelessWidget {
  const PendingRequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<RequestsBloc>(context)..getRequests(),
      child: BlocConsumer<RequestsBloc, RequestsStates>(
        listener: (context, state) {
          if (state is ApproveRequestSuccessState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.message.toString()),
              duration: const Duration(
                seconds: 3,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            RequestsBloc.get(context).getRequests();
          } else if (state is ApproveRequestErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.message.toString()),
              duration: const Duration(
                seconds: 3,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            RequestsBloc.get(context).getRequests();
          } else if (state is RejectRequestSuccessState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.message.toString()),
              duration: const Duration(
                seconds: 3,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            RequestsBloc.get(context).getRequests();
          } else if (state is RejectRequestErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.message.toString()),
              duration: const Duration(
                seconds: 3,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            RequestsBloc.get(context).getRequests();
          }
        },
        builder: (context, state) {
          log(state.toString());
          return state is RequestSuccessState &&
                  RequestsBloc.get(context).pendingRequests.isNotEmpty
              ? ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              IconsAssets.personIcon,
                              height: AppSize.s24,
                              color: ColorManager.primary,
                            ),
                            const SizedBox(
                              width: AppSize.s8,
                            ),
                            Expanded(
                              child: Text(
                                RequestsBloc.get(context)
                                    .pendingRequests[index]
                                    .employeeName,
                                style: TextStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                            ),
                            RequestsBloc.get(context)
                                    .pendingRequests[index]
                                    .attachment
                                    .isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      RequestsBloc.get(context).convertToFile(
                                        name: RequestsBloc.get(context)
                                            .pendingRequests[index]
                                            .employeeName
                                            .replaceAll(" ", "_"),
                                        extension: RequestsBloc.get(context)
                                            .pendingRequests[index]
                                            .attachmentExtension
                                            .toString(),
                                        base64String: RequestsBloc.get(context)
                                            .pendingRequests[index]
                                            .attachment,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.download,
                                      size: 28,
                                      color: ColorManager.primary,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.emailIcon,
                          text: AppStrings.message,
                          subText: RequestsBloc.get(context)
                              .pendingRequests[index]
                              .type,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              IconsAssets.messageQuestionIcon,
                              height: AppSize.s24,
                              color: ColorManager.primary,
                            ),
                            const SizedBox(
                              width: AppSize.s8,
                            ),
                            Expanded(
                              child: Text(
                                RequestsBloc.get(context)
                                    .pendingRequests[index]
                                    .reason,
                                style: TextStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                            )
                          ],
                        ),
                        UserRequestWidget(
                            iconPath: IconsAssets.calenderIcon,
                            text: AppStrings.date,
                            subText: DateFormat('EEE, MMM dd, yyyy').format(
                                DateTime.parse(RequestsBloc.get(context)
                                    .pendingRequests[index]
                                    .startDate))),
                        UserRequestWidget(
                          iconPath: IconsAssets.calenderIcon,
                          text: AppStrings.date,
                          subText: DateFormat('EEE, MMM dd, yyyy').format(
                            DateTime.parse(
                              RequestsBloc.get(context)
                                  .pendingRequests[index]
                                  .endDate,
                            ),
                          ),
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.clockIcon,
                          text: AppStrings.duration,
                          subText: RequestsBloc.get(context)
                              .pendingRequests[index]
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
                                        .pendingRequests[index]
                                        .id,
                                    type: RequestsBloc.get(context)
                                        .pendingRequests[index]
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
                                          .pendingRequests[index]
                                          .id,
                                      type: RequestsBloc.get(context)
                                          .pendingRequests[index]
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
                  itemCount: RequestsBloc.get(context).pendingRequests.length,
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
                  : state is RequestErrorState ||
                          RequestsBloc.get(context).pendingRequests.isEmpty
                      ? ErrorsWidget(
                          onPress: () {},
                        )
                      : ShimmerCustom(
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
                          ),
                        );
        },
      ),
    );
  }
}
