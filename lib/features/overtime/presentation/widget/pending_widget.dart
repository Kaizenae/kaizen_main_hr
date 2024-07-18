import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/features/overtime/controller/bloc.dart';
import 'package:Attendace/features/overtime/controller/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../../core/widgets/snack_bar/snack_bar_widget.dart';

class PendingWidget extends StatelessWidget {
  const PendingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OvertimeBloc, OvertimeStates>(
      listener: (context, state) {
        if (state is CancelMyRequestSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
              message: state.message.toString(), context: context));
        } else if (state is CancelMyRequestErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
              message: state.message.toString(), context: context));
        }
      },
      builder: (context, state) {
        return state is GetOvertimeLoadingState
            ? ShimmerCustom(
                child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemBuilder: (context, index) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
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
            : OvertimeBloc.get(context).peindingOvertime.isNotEmpty
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
                            "${DateFormat('HH:mm').format(DateTime.parse(OvertimeBloc.get(context).peindingOvertime[index].dateTimeFrom))} - ${DateFormat('HH:mm').format(DateTime.parse(OvertimeBloc.get(context).peindingOvertime[index].dateTimeTo))}",
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
                                .peindingOvertime[index]
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
                                  alignment: AlignmentDirectional.centerStart,
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    DateFormat('EEE, MMM, dd, yyyy').format(
                                        DateTime.parse(OvertimeBloc.get(context)
                                            .peindingOvertime[index]
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
                                    color: ColorManager.yellow,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      OvertimeBloc.get(context)
                                          .peindingOvertime[index]
                                          .state,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                            color: ColorManager.orange,
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
                                  .peindingOvertime[index]
                                  .approvers
                                  .isNotEmpty
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, ind) => Text(
                                    "${OvertimeBloc.get(context).peindingOvertime[index].approvers[ind].userName} - ${OvertimeBloc.get(context).peindingOvertime[index].approvers[ind].state}",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  separatorBuilder: (context, ind) =>
                                      const SizedBox(
                                    height: 10,
                                  ),
                                  itemCount: OvertimeBloc.get(context)
                                      .peindingOvertime[index]
                                      .approvers
                                      .length,
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: ElevatedButtonCustom(
                              fontSize: FontSize.s14,
                              colors: ColorManager.error,
                              borderColor: ColorManager.error,
                              fontWeight: FontWeight.w800,
                              width: MediaQuery.of(context).size.width / 4,
                              text: AppStrings.cancel,
                              onPressed: () {
                                OvertimeBloc.get(context).cancelMyRequest(
                                    requestId: OvertimeBloc.get(context)
                                        .peindingOvertime[index]
                                        .id);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    itemCount:
                        OvertimeBloc.get(context).peindingOvertime.length,
                  )
                : const ErrorsWidget();
      },
    );
  }
}
