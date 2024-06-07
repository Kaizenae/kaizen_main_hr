// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../data/late_in_early_out_model.dart';
import '../controller/cubit.dart';

class EarlyOutLateInItem extends StatelessWidget {
  const EarlyOutLateInItem(
      {super.key,
      required this.item,
      required this.title,
      required this.isPending,
      required this.bgStatusColor,
      required this.statusColor,
      required this.type});
  final ResponseModel item;
  final String title;
  final bool isPending;
  final String type;
  final Color bgStatusColor;
  final Color statusColor;
  @override
  Widget build(BuildContext context) {
    return Container(
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
              DateFormat('EEE, MMM, dd, yyyy')
                  .format(DateTime.parse(item.date)),
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
            item.reason,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                type,
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
                  color: bgStatusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item.state,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: statusColor,
                      ),
                ),
              ),
            ],
          ),
          item.approvers.isNotEmpty
              ? const SizedBox(
                  height: 4,
                )
              : const SizedBox(),
          item.approvers.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item.approvers[index].userName} - ${item.approvers[index].state}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      item.approvers[index].reason.isNotEmpty
                          ? Text(
                              item.approvers[index].reason,
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
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                  itemCount: item.approvers.length,
                )
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          isPending == true
              ? Align(
                  alignment: AlignmentDirectional.center,
                  child: ElevatedButtonCustom(
                    fontSize: FontSize.s14,
                    colors: ColorManager.error,
                    borderColor: ColorManager.error,
                    fontWeight: FontWeight.w800,
                    width: MediaQuery.of(context).size.width / 4,
                    text: AppStrings.cancel,
                    onPressed: () {
                      EarlyOutLateInCubit.get(context)
                          .cancelMyRequest(requestId: item.id, type: type);
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}



/**
  Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserRequestWidget(
              iconPath: IconsAssets.emailIcon,
              text: AppStrings.message,
              subText: title,
            ),
            UserRequestWidget(
                iconPath: IconsAssets.calenderIcon,
                text: AppStrings.date,
                // subText: DateFormat('EEE, MMM, dd, yyyy')
                //     .format(DateTime.parse(item.date))),
            const SizedBox(
              height: 4,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  IconsAssets.messageQuestionIcon,
                  height: AppSize.s24,
                  color: ColorManager.skyColor,
                ),
                const SizedBox(
                  width: AppSize.s8,
                ),
                Expanded(
                  child: Text(
                    // item.reason,
                    style: TextStyle(
                      fontFamily: FontConstants.fontFamily,
                      color: ColorManager.primary,
                      fontSize: FontSize.s16,
                    ),
                  ),
                )
              ],
            ),
            UserRequestWidget(
                iconPath: IconsAssets.clockIcon,
                text: AppStrings.status,
                // subText: item.state),
            const SizedBox(
              height: 10,
            ),
            item.approvers.isNotEmpty
                ? Text(
                    AppStrings.approvers,
                    style: TextStyle(
                        fontFamily: FontConstants.fontFamily,
                        color: ColorManager.black,
                        fontSize: FontSize.s18,
                        fontWeight: FontWeight.w600),
                  )
                : const SizedBox(),
            item.approvers.isNotEmpty
                ? const SizedBox(
                    height: 10,
                  )
                : const SizedBox(),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    IconsAssets.personIcon,
                                    height: AppSize.s24,
                                    color: ColorManager.skyColor,
                                  ),
                                  const SizedBox(
                                    width: AppSize.s8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      item.approvers[index].userName,
                                      style: TextStyle(
                                        fontFamily: FontConstants.fontFamily,
                                        color: ColorManager.primary,
                                        fontSize: FontSize.s16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              item.approvers[index].state,
                              style: TextStyle(
                                fontFamily: FontConstants.fontFamily,
                                color: ColorManager.primary,
                                fontSize: FontSize.s14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          item.approvers[index].reason,
                          style: TextStyle(
                            fontFamily: FontConstants.fontFamily,
                            fontSize: FontSize.s14,
                            color: ColorManager.grey,
                          ),
                        )
                      ],
                    ),
                itemCount: item.approvers.length),
            isPending == true
                ? const SizedBox(
                    height: 10,
                  )
                : const SizedBox(),
            isPending == true
                ? ElevatedButtonCustom(
                    fontSize: FontSize.s14,
                    colors: ColorManager.error,
                    borderColor: ColorManager.error,
                    fontWeight: FontWeight.w800,
                    width: double.infinity,
                    text: 'Cancel Request',
                    onPressed: () {
                      EarlyOutLateInCubit.get(context)
                          .cancelMyRequest(requestId: item.id, type: type);
                    },
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
 
 */