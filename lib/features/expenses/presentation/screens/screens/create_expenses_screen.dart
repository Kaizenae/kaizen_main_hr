import 'package:Attendace/core/utils/assets_manager.dart';
import 'package:Attendace/core/utils/color_manager.dart';
import 'package:Attendace/core/utils/enums.dart';
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
import '../../widget/drop_down_widget.dart';

class CreateExpensesScreen extends StatefulWidget {
  const CreateExpensesScreen({
    super.key,
  });

  @override
  State<CreateExpensesScreen> createState() => _CreateExpensesScreenState();
}

class _CreateExpensesScreenState extends State<CreateExpensesScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: AppStrings.expensesRequest,
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
                        DropDownWidget(
                          label: AppStrings.category,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text(
                              AppStrings.total,
                              style: TextStyle(
                                color: ColorManager.primary,
                              ),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        DropDownWidget(
                          label: AppStrings.includedTaxes,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              AppStrings.paidBy,
                              style: TextStyle(
                                color: ColorManager.primary,
                                fontSize: FontSize.s16,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Radio<PAIDBY>(
                                    value: PAIDBY.Employee,
                                    groupValue: paidBy,
                                    onChanged: (PAIDBY? value) {
                                      setState(() {
                                        paidBy = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    AppStrings.employee,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: ColorManager.black),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Radio<PAIDBY>(
                                    value: PAIDBY.Company,
                                    groupValue: paidBy,
                                    onChanged: (PAIDBY? value) {
                                      setState(() {
                                        paidBy = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    AppStrings.company,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: ColorManager.black),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text(
                              AppStrings.billReference,
                              style: TextStyle(
                                color: ColorManager.primary,
                              ),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),

                        DropDownWidget(
                          label: AppStrings.analytic,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextCustom(
                          fontSize: FontSize.s14,
                          text: AppStrings.expenseDate,
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
                            color: ColorManager.textFormColor,
                            border: Border.all(
                                color: ColorManager.textFormColor, width: 2),
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
                          text: AppStrings.attachment,
                          color: ColorManager.textFormLabelColor,
                        ),
                        const SizedBox(
                          height: AppSize.s8,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorManager.textFormColor,
                            border: Border.all(
                                color: ColorManager.textFormColor, width: 2),
                          ),
                          child: InkWell(
                            onTap: () async {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextCustom(
                                  text: AppStrings.fileName,
                                  color: ColorManager.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                                SvgPicture.asset(
                                  IconsAssets.attachmentIcon,
                                  width: 24,
                                  height: 24,
                                  // ignore: deprecated_member_use
                                  color: const Color(0xff3D8BD3),
                                )
                              ],
                            ),
                          ),
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
