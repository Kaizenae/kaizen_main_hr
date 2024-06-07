import 'package:Attendace/core/utils/assets_manager.dart';
import 'package:Attendace/core/utils/color_manager.dart';
import 'package:Attendace/core/utils/font_manager.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/utils/values_manager.dart';
import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../../core/widgets/text_custom/text_custom.dart';

class CreateOvertimeScreen extends StatefulWidget {
  const CreateOvertimeScreen({
    super.key,
  });

  @override
  State<CreateOvertimeScreen> createState() => _CreateOvertimeScreenState();
}

class _CreateOvertimeScreenState extends State<CreateOvertimeScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: AppStrings.overtimeRequest,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),

                        TextCustom(
                          fontSize: FontSize.s14,
                          text: AppStrings.date,
                          color: ColorManager.textFormLabelColor,
                        ),
                        const SizedBox(
                          height: AppSize.s4,
                        ),
                        //Date
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorManager.white,
                            border:
                                Border.all(color: ColorManager.white, width: 2),
                          ),
                          child: InkWell(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now()
                                          .subtract(const Duration(days: 1000)),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 1000)))
                                  .then(
                                (value) {},
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextCustom(
                                  text: DateFormat("dd,MMM,yyyy")
                                      .format(DateTime.now())
                                      .toString(),
                                  color: ColorManager.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                                SvgPicture.asset(
                                  IconsAssets.calenderIcon,
                                  width: 24,
                                  height: 24,
                                )
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 12,
                        ),
                        TextCustom(
                          fontSize: FontSize.s14,
                          text: AppStrings.from,
                          color: ColorManager.textFormLabelColor,
                        ),
                        const SizedBox(
                          height: AppSize.s4,
                        ),
                        //Date
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorManager.white,
                            border:
                                Border.all(color: ColorManager.white, width: 2),
                          ),
                          child: InkWell(
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then(
                                (value) {},
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextCustom(
                                  text: DateFormat("jm")
                                      .format(DateTime.now())
                                      .toString(),
                                  color: ColorManager.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                                SvgPicture.asset(
                                  IconsAssets.calenderIcon,
                                  width: 24,
                                  height: 24,
                                )
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 12,
                        ),
                        TextCustom(
                          fontSize: FontSize.s14,
                          text: AppStrings.to,
                          color: ColorManager.textFormLabelColor,
                        ),
                        const SizedBox(
                          height: AppSize.s4,
                        ),
                        //Date
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorManager.white,
                            border:
                                Border.all(color: ColorManager.white, width: 2),
                          ),
                          child: InkWell(
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then(
                                (value) {},
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextCustom(
                                  text: DateFormat("jm")
                                      .format(DateTime.now())
                                      .toString(),
                                  color: ColorManager.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                                SvgPicture.asset(
                                  IconsAssets.calenderIcon,
                                  width: 24,
                                  height: 24,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          maxLines: 5,
                          decoration: const InputDecoration(
                            label: Text(
                              AppStrings.description,
                              style: TextStyle(
                                fontFamily: FontConstants.fontFamily,
                                color: ColorManager.primary,
                              ),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButtonCustom(
                    text: AppStrings.submit,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.s18,
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
