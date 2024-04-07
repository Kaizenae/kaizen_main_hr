// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../controllers/requests_controller/bloc.dart';
import '../controllers/requests_controller/states.dart';
import 'userRequest_widget.dart';

class ApprovedRequestsWidget extends StatelessWidget {
  const ApprovedRequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<RequestsBloc>(context)..getRequests(),
      child: BlocConsumer<RequestsBloc, RequestsStates>(
        listener: (context, state) {
          if (state is RejectRequestSuccessState) {
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
          } else if (state is CannotOpenFileState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.message.toString()),
              duration: const Duration(
                seconds: 3,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          log(state.toString());
          return RequestsBloc.get(context).approvedRequests.isNotEmpty
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
                                    .approvedRequests[index]
                                    .employeeName,
                                style: TextStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                            ),
                            RequestsBloc.get(context)
                                    .approvedRequests[index]
                                    .attachment
                                    .isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      RequestsBloc.get(context).convertToFile(
                                        name: RequestsBloc.get(context)
                                            .approvedRequests[index]
                                            .employeeName
                                            .replaceAll(" ", "_"),
                                        extension: RequestsBloc.get(context)
                                            .approvedRequests[index]
                                            .attachmentExtension
                                            .toString(),
                                        base64String: RequestsBloc.get(context)
                                            .approvedRequests[index]
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
                              .approvedRequests[index]
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
                                    .approvedRequests[index]
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
                            DateTime.parse(
                              RequestsBloc.get(context)
                                  .approvedRequests[index]
                                  .startDate,
                            ),
                          ),
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.calenderIcon,
                          text: AppStrings.date,
                          subText: DateFormat('EEE, MMM dd, yyyy').format(
                            DateTime.parse(
                              RequestsBloc.get(context)
                                  .approvedRequests[index]
                                  .endDate,
                            ),
                          ),
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.clockIcon,
                          text: AppStrings.duration,
                          subText: RequestsBloc.get(context)
                              .approvedRequests[index]
                              .duration
                              .toString(),
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.clockIcon,
                          text: AppStrings.duration,
                          subText: RequestsBloc.get(context)
                              .approvedRequests[index]
                              .state
                              .toString(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButtonCustom(
                          fontSize: FontSize.s14,
                          colors: ColorManager.error,
                          borderColor: ColorManager.error,
                          fontWeight: FontWeight.w800,
                          width: double.infinity,
                          text: 'Reject Request',
                          onPressed: () {
                            RequestsBloc.get(context).rejectRequest(
                                requestId: RequestsBloc.get(context)
                                    .approvedRequests[index]
                                    .id,
                                type: RequestsBloc.get(context)
                                    .approvedRequests[index]
                                    .type);
                          },
                        ),
                      ],
                    ),
                  ),
                  itemCount: RequestsBloc.get(context).approvedRequests.length,
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
                          RequestsBloc.get(context).approvedRequests.isEmpty
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
                              ),
                            ),
                            itemCount: 2,
                          ),
                        );
        },
      ),
    );
  }
}
