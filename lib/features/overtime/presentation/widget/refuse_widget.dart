// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/features/overtime/controller/states.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../controller/bloc.dart';

class RefusedWidget extends StatelessWidget {
  RefusedWidget({
    super.key,
  });

  var state;
  @override
  Widget build(BuildContext context) {
    return state is GetOvertimeLoadingState
        ? ShimmerCustom(
            child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s20),
                color: ColorManager.white,
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.lightGrey.withOpacity(.1),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "${AppStrings.date}: ",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "00:00",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "${AppStrings.hours}: ",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "00:00",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color: ColorManager.error,
                                    ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "${AppStrings.from}: ",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '00: 00',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "${AppStrings.to}: ",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '00: 00',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            itemCount: 10,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 20,
            ),
          ))
        : OvertimeBloc.get(context).rejectOvertime.isNotEmpty
            ? ListView.separated(
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
                        "${DateFormat('HH:mm').format(DateTime.parse(OvertimeBloc.get(context).rejectOvertime[index].dateTimeFrom))} - ${DateFormat('HH:mm').format(DateTime.parse(OvertimeBloc.get(context).rejectOvertime[index].dateTimeTo))}",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        OvertimeBloc.get(context)
                            .rejectOvertime[index]
                            .description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                DateFormat('EEE, MMM, dd, yyyy').format(
                                    DateTime.parse(OvertimeBloc.get(context)
                                        .rejectOvertime[index]
                                        .date)),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 14),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: ColorManager.error.withOpacity(.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  OvertimeBloc.get(context)
                                      .rejectOvertime[index]
                                      .state,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        color: ColorManager.white,
                                      ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      OvertimeBloc.get(context)
                              .rejectOvertime[index]
                              .approvers
                              .isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, ind) => Text(
                                "${OvertimeBloc.get(context).rejectOvertime[index].approvers[ind].userName} - ${OvertimeBloc.get(context).rejectOvertime[index].approvers[ind].state}",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              separatorBuilder: (context, ind) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemCount: OvertimeBloc.get(context)
                                  .rejectOvertime[index]
                                  .approvers
                                  .length,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                itemCount: OvertimeBloc.get(context).rejectOvertime.length,
              )
            : const ErrorsWidget();
  }
}
