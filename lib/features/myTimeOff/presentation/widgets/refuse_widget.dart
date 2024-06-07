// ignore_for_file: deprecated_member_use

import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:Attendace/features/myTimeOff/presentation/controller/myTimeOff_cubit.dart';
import 'package:Attendace/features/myTimeOff/presentation/controller/myTimeOff_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/color_manager.dart';

class RefusedWidget extends StatelessWidget {
  const RefusedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MyTimeOffCubit>(context)..getMyTimeOffFun(),
      child: BlocConsumer<MyTimeOffCubit, MyTimeOffState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MyTimeOffCubit.get(context);

          return cubit.myTimeOffRefuse.isNotEmpty
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
                            "${DateFormat('EEE, MMM dd, yyyy').format(DateTime.parse(cubit.myTimeOffRefuse[index].start))} - ${DateFormat('EEE, MMM dd, yyyy').format(DateTime.parse(cubit.myTimeOffRefuse[index].end))}",
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
                          cubit.myTimeOffRefuse[index].description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              cubit.myTimeOffRefuse[index].holidayStatus,
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
                                color: ColorManager.error.withOpacity(.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                cubit.myTimeOffRefuse[index].state,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color: ColorManager.white,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        cubit.myTimeOffRefuse[index].approvers.isNotEmpty
                            ? const SizedBox(
                                height: 4,
                              )
                            : const SizedBox(),
                        cubit.myTimeOffRefuse[index].approvers.isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, ind) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${cubit.myTimeOffRefuse[index].approvers[ind].userName} - ${cubit.myTimeOffRefuse[index].approvers[ind].state}",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    cubit.myTimeOffRefuse[index].approvers[ind]
                                            .reason.isNotEmpty
                                        ? Text(
                                            cubit.myTimeOffRefuse[index]
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
                                    .myTimeOffRefuse[index].approvers.length,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  itemCount: cubit.myTimeOffRefuse.length,
                )
              : state is GetMyTimeOffLoading
                  ? ShimmerCustom(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20),
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
