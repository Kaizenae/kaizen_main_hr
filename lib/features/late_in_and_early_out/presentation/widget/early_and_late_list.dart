// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable
import 'package:Attendace/features/late_in_and_early_out/presentation/widget/early_out_late_in_item.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../controller/states.dart';

class EarlyAndLateList extends StatelessWidget {
  EarlyAndLateList({
    super.key,
    required this.list,
    required this.state,
    required this.title,
    required this.isPending,
    required this.bgStatusColor,
    required this.statusColor,
  });
  final List list;
  final bool isPending;
  var state;
  final Color bgStatusColor;
  final Color statusColor;
  final String title;
  @override
  Widget build(BuildContext context) {
    if (title == AppStrings.lateInRequest) {
      if (state is GetLateInLoadingState) {
        return ShimmerCustom(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 20),
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.lightGrey.withOpacity(.1),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Oct 12, 2020 - Oct 12, 2020",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Going on a vacation ",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Annual Leave ",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 14),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.yellow,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Pending",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: ColorManager.orange,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Akhil Retnan - New",
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ),
            itemCount: 10,
          ),
        );
      } else if (list.isEmpty) {
        return const ErrorsWidget();
      } else {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 20),
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => EarlyOutLateInItem(
            item: list[index],
            type: "Late In",
            isPending: isPending,
            title: title,
            bgStatusColor: bgStatusColor,
            statusColor: statusColor,
          ),
          itemCount: list.length,
        );
      }
    } else if (title == AppStrings.earlyOutRequest) {
      if (state is GetEarlyOutLoadingState) {
        return ShimmerCustom(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 20),
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.lightGrey.withOpacity(.1),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Oct 12, 2020 - Oct 12, 2020",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Going on a vacation ",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Annual Leave ",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 14),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.yellow,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Pending",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: ColorManager.orange,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Akhil Retnan - New",
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ),
            itemCount: 10,
          ),
        );
      } else if (list.isEmpty) {
        return const ErrorsWidget();
      } else {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 20),
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => EarlyOutLateInItem(
            item: list[index],
            bgStatusColor: bgStatusColor,
            statusColor: statusColor,
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
