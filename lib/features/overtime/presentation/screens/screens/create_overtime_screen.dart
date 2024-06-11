import 'dart:ffi';

import 'package:Attendace/core/utils/assets_manager.dart';
import 'package:Attendace/core/utils/color_manager.dart';
import 'package:Attendace/core/utils/font_manager.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/utils/values_manager.dart';
import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
import 'package:Attendace/features/overtime/controller/bloc.dart';
import 'package:Attendace/features/overtime/controller/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../../core/widgets/snack_bar/snack_bar_widget.dart';
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
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OvertimeBloc(),
      child: ScaffoldCustom(
        appBarCustom: const AppBarCustom(
          text: AppStrings.overtimeRequest,
        ),
        body: BlocConsumer<OvertimeBloc, OvertimeStates>(
          listener: (context, state) {
            if (state is CreateOvertimeSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                  message: state.message.toString(), context: context));
              Navigator.pop(context);
              Navigator.pop(context);
            } else if (state is CreateOvertimeErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                  message: state.message.toString(), context: context));
            }
          },
          builder: (context, state) {
            return Padding(
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
                          child: Form(
                            key: formKey,
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
                                    border: Border.all(
                                        color: ColorManager.white, width: 2),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now()
                                                  .subtract(const Duration(
                                                      days: 1000)),
                                              lastDate: DateTime.now().add(
                                                  const Duration(days: 1000)))
                                          .then(
                                        (value) {
                                          OvertimeBloc.get(context)
                                                  .selectedDate =
                                              DateFormat("yyyy-MM-dd").format(
                                                  DateTime.parse(
                                                      value.toString()));

                                          OvertimeBloc.get(context).changeDate(
                                            DateFormat("yyyy-MM-dd").format(
                                              DateTime.parse(
                                                value.toString(),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextCustom(
                                          text: OvertimeBloc.get(context)
                                              .selectedDate
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
                                    border: Border.all(
                                        color: ColorManager.white, width: 2),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then(
                                        (value) {
                                          OvertimeBloc.get(context)
                                                  .selectedFromTime =
                                              DateFormat("HH:mm:ss")
                                                  .format(DateTime(
                                                      DateTime.now().year,
                                                      DateTime.now().month,
                                                      DateTime.now().day,
                                                      value!.hour,
                                                      value.minute))
                                                  .toString();

                                          setState(() {});
                                        },
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextCustom(
                                          text: OvertimeBloc.get(context)
                                              .selectedFromTime
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
                                    border: Border.all(
                                        color: ColorManager.white, width: 2),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then(
                                        (value) {
                                          OvertimeBloc.get(context)
                                                  .selectedToTime =
                                              DateFormat("HH:mm:ss")
                                                  .format(DateTime(
                                                      DateTime.now().year,
                                                      DateTime.now().month,
                                                      DateTime.now().day,
                                                      value!.hour,
                                                      value.minute))
                                                  .toString();

                                          setState(() {});
                                        },
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextCustom(
                                          text: OvertimeBloc.get(context)
                                              .selectedToTime
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
                                  controller: descriptionController,
                                  maxLines: 5,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return AppStrings
                                          .pleaseEnterDescriptionField;
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
                              ],
                            ),
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
                            if (formKey.currentState!.validate()) {
                              OvertimeBloc.get(context).createOvertime(
                                  description: descriptionController.text);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
