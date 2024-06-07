// ignore_for_file: deprecated_member_use

import 'package:Attendace/core/utils/font_manager.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:Attendace/core/widgets/snack_bar/snack_bar_widget.dart';
import 'package:Attendace/features/myTimeOff/presentation/controller/myTimeOff_cubit.dart';
import 'package:Attendace/features/myTimeOff/presentation/controller/myTimeOff_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';

class PendingTimeWidget extends StatelessWidget {
  const PendingTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MyTimeOffCubit>(context)..getMyTimeOffFun(),
      child: BlocConsumer<MyTimeOffCubit, MyTimeOffState>(
        listener: (context, state) {
          if (state is CancelMyRequestSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                message: state.message.toString(), context: context));
            BlocProvider.of<MyTimeOffCubit>(context).getMyTimeOffFun();
          } else if (state is CancelMyRequestErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                message: state.message.toString(), context: context));
          }
        },
        builder: (context, state) {
          var cubit = MyTimeOffCubit.get(context);

          return cubit.myTimeOffPending.isNotEmpty
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
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${DateFormat('EEE, MMM dd, yyyy').format(DateTime.parse(cubit.myTimeOffPending[index].start))} - ${DateFormat('EEE, MMM dd, yyyy').format(DateTime.parse(cubit.myTimeOffPending[index].end))}",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 16),
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          cubit.myTimeOffPending[index].description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              cubit.myTimeOffPending[index].holidayStatus,
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
                                cubit.myTimeOffPending[index].state,
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
                        cubit.myTimeOffPending[index].approvers.isNotEmpty
                            ? const SizedBox(
                                height: 4,
                              )
                            : const SizedBox(),
                        cubit.myTimeOffPending[index].approvers.isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, ind) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${cubit.myTimeOffPending[index].approvers[ind].userName} - ${cubit.myTimeOffPending[index].approvers[ind].state}",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    cubit.myTimeOffPending[index].approvers[ind]
                                            .reason.isNotEmpty
                                        ? Text(
                                            cubit.myTimeOffPending[index]
                                                .approvers[ind].reason,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  color: ColorManager.darkGrey,
                                                ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 8,
                                ),
                                itemCount: cubit
                                    .myTimeOffPending[index].approvers.length,
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
                              cubit.cancelMyRequest(
                                  requestId: cubit.myTimeOffPending[index].id);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  itemCount: cubit.myTimeOffPending.length,
                )
              : state is GetMyTimeOffPendingLoading
                  ? ShimmerCustom(
                      child: ListView.separated(
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
                    )
                  : ErrorsWidget(
                      onPress: () {
                        cubit.getMyTimeOffFun();
                      },
                    );
        },
      ),
    );
  }
}
