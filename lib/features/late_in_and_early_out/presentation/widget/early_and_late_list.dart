// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:developer';

import 'package:Attendace/features/late_in_and_early_out/presentation/widget/early_out_late_in_item.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../notifications/presentation/widgets/userRequest_widget.dart';
import '../controller/states.dart';

class EarlyAndLateList extends StatelessWidget {
  EarlyAndLateList({
    super.key,
    required this.list,
    required this.state,
    required this.title,
    required this.isPending,
  });
  final List list;
  final bool isPending;
  var state;
  final String title;
  @override
  Widget build(BuildContext context) {
    log(state.toString());
    if (title == AppStrings.lateInRequest) {
      if (state is GetLateInLoadingState) {
        return ShimmerCustom(
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
          itemCount: 5,
        ));
      } else if (list.isEmpty) {
        return const ErrorsWidget();
      } else {
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => EarlyOutLateInItem(
            item: list[index],
            type: "Late In",
            isPending: isPending,
            title: title,
          ),
          itemCount: list.length,
        );
      }
    } else if (title == AppStrings.earlyOutRequest) {
      if (state is GetEarlyOutLoadingState) {
        return ShimmerCustom(
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
          itemCount: 5,
        ));
      } else if (list.isEmpty) {
        return const ErrorsWidget();
      } else {
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => EarlyOutLateInItem(
            item: list[index],
            title: title,
            type: "Early Out",
            isPending: isPending,
          ),
          itemCount: list.length,
        );
      }
    } else {
      return const SizedBox();
    }
  }
}
