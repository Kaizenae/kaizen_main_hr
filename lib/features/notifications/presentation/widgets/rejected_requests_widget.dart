// ignore_for_file: deprecated_member_use

import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/color_manager.dart';
import '../controllers/requests_controller/bloc.dart';
import '../controllers/requests_controller/states.dart';

class RejectedRequestsWidget extends StatelessWidget {
  const RejectedRequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<RequestsBloc>(context)..getRequests(),
      child: BlocConsumer<RequestsBloc, RequestsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return state is RequestSuccessState &&
                  RequestsBloc.get(context).rejectedRequests.isNotEmpty
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
                          "${DateFormat('EEE, MMM dd, yyyy').format(DateTime.parse(RequestsBloc.get(context).rejectedRequests[index].startDate))} - ${DateFormat('EEE, MMM dd, yyyy').format(DateTime.parse(RequestsBloc.get(context).rejectedRequests[index].endDate))}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          RequestsBloc.get(context)
                              .rejectedRequests[index]
                              .reason,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              RequestsBloc.get(context)
                                  .rejectedRequests[index]
                                  .employeeName,
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
                                RequestsBloc.get(context)
                                    .rejectedRequests[index]
                                    .duration
                                    .toString(),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              RequestsBloc.get(context)
                                  .rejectedRequests[index]
                                  .type,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            RequestsBloc.get(context)
                                    .rejectedRequests[index]
                                    .attachment
                                    .isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      RequestsBloc.get(context).convertToFile(
                                        name: RequestsBloc.get(context)
                                            .rejectedRequests[index]
                                            .employeeName
                                            .replaceAll(" ", "_"),
                                        extension: RequestsBloc.get(context)
                                            .rejectedRequests[index]
                                            .attachmentExtension
                                            .toString(),
                                        base64String: RequestsBloc.get(context)
                                            .rejectedRequests[index]
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
                      ],
                    ),
                  ),
                  itemCount: RequestsBloc.get(context).rejectedRequests.length,
                )
              // ignore: dead_code
              : state is RequestLoadingState
                  ? ShimmerCustom(
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
                              "Going to vacation",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Tony Saji Thomas",
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
                                    "3",
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
                              "Annual Leave",
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          ],
                        ),
                      ),
                      itemCount: 10,
                    ))
                  : state is RequestErrorState ||
                          RequestsBloc.get(context).rejectedRequests.isEmpty
                      ? ErrorsWidget(
                          onPress: () {},
                        )
                      : ShimmerCustom(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
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
                                    color:
                                        ColorManager.lightGrey.withOpacity(.1),
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
                                    "Going to vacation",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Tony Saji Thomas",
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          "3",
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
                                    "Annual Leave",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  )
                                ],
                              ),
                            ),
                            itemCount: 10,
                          ),
                        );
        },
      ),
    );
  }
}
