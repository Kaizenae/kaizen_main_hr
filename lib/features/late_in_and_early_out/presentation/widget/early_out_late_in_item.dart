// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../myLoans/presentation/widgets/userRequest_widget.dart';
import '../../data/late_in_early_out_model.dart';
import '../controller/cubit.dart';

class EarlyOutLateInItem extends StatelessWidget {
  const EarlyOutLateInItem(
      {super.key,
      required this.item,
      required this.title,
      required this.isPending,
      required this.type});
  final ResponseModel item;
  final String title;
  final bool isPending;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                subText: DateFormat('EEE, MMM, dd, yyyy')
                    .format(DateTime.parse(item.date))),
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
                    item.reason,
                    style: TextStyle(
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
                subText: item.state),
            const SizedBox(
              height: 10,
            ),
            item.approvers.isNotEmpty
                ? Text(
                    AppStrings.approvers,
                    style: TextStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s18,
                        fontWeight: FontWeight.w600),
                  )
                : const SizedBox(),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Row(
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
                            color: ColorManager.primary,
                            fontSize: FontSize.s14,
                          ),
                        ),
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
  }
}
