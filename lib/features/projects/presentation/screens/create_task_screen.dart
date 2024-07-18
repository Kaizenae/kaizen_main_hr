import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../widgets/drop_down_widget.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: AppStrings.createTask,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
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
                          TextFormField(
                            decoration: const InputDecoration(
                              label: Text(
                                AppStrings.taskName,
                                style: TextStyle(
                                  color: ColorManager.primary,
                                  fontFamily: FontConstants.fontFamily,
                                ),
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextCustom(
                            fontSize: FontSize.s14,
                            text: AppStrings.deadline,
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
                              border: Border.all(
                                  color: ColorManager.white, width: 2),
                            ),
                            child: InkWell(
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now().subtract(
                                            const Duration(days: 1000)),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 1000)))
                                    .then(
                                  (value) {},
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                          DropDownWidget(
                            label: AppStrings.taskType,
                          ),

                          const SizedBox(
                            height: 12,
                          ),
                          TextCustom(
                            fontSize: FontSize.s14,
                            text: AppStrings.assignUsers,
                            color: ColorManager.textFormLabelColor,
                          ),
                          const SizedBox(
                            height: AppSize.s4,
                          ),
                          MultiSelectDropDown(
                            onOptionSelected: (options) {
                              debugPrint(options.toString());
                            },
                            options: const <ValueItem>[
                              ValueItem(label: 'Option 1', value: '1'),
                              ValueItem(label: 'Option 2', value: '2'),
                              ValueItem(label: 'Option 3', value: '3'),
                              ValueItem(label: 'Option 4', value: '4'),
                              ValueItem(label: 'Option 5', value: '5'),
                              ValueItem(label: 'Option 6', value: '6'),
                            ],
                            maxItems: 7,
                            disabledOptions: const [
                              ValueItem(label: 'Option 1', value: '1')
                            ],
                            selectionType: SelectionType.multi,
                            chipConfig:
                                const ChipConfig(wrapType: WrapType.wrap),
                            dropdownHeight: 300,
                            optionTextStyle: const TextStyle(fontSize: 16),
                            selectedOptionIcon: const Icon(Icons.check_circle),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            maxLines: 5,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return AppStrings.pleaseEnterDescriptionField;
                              }
                              return null;
                            },
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
                              color: ColorManager.white,
                              border: Border.all(
                                  color: ColorManager.white, width: 2),
                            ),
                            child: InkWell(
                              onTap: () async {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                        ]),
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
