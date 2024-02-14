import 'dart:io';

import 'package:Attendace/core/utils/font_manager.dart';
import 'package:Attendace/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:Attendace/core/widgets/text_custom/text_custom.dart';
import 'package:Attendace/core/widgets/text_form_field/text_form_field_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/component.dart';
import '../../../create_timeOff/presentation/controller/create_timeOff_cubit.dart';
import '../../../create_timeOff/presentation/controller/create_timeOff_state.dart';

class LateInEarlyOutScreen extends StatefulWidget {
  const LateInEarlyOutScreen({super.key, required this.title});
  final String title;

  @override
  State<LateInEarlyOutScreen> createState() => _LateInEarlyOutScreenState();
}

class _LateInEarlyOutScreenState extends State<LateInEarlyOutScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: AppBarCustom(text: widget.title),
      body: BlocConsumer<CreateTimeOffCubit, CreateTimeOffState>(
        listener: (context, state) {
          if (state is CreateTimeOffSuccess) {
            Navigator.pop(context);
            showToast(message: state.createTimeOffEntity.resultEntity.message);
          } else if (state is CreateTimeOffError) {
            showToast(message: state.message, color: ColorManager.error);
          }
        },
        builder: (context, state) {
          var cubit = CreateTimeOffCubit.get(context);
          return Padding(
            padding: EdgeInsets.all(AppPadding.p16.r),
            child: SafeArea(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: AppSize.s4,
                    ),

                    const TextCustom(
                      text: 'Date',
                      color: ColorManager.textFormLabelColor,
                    ),
                    const SizedBox(
                      height: AppSize.s4,
                    ),
//Date
                    Container(
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: ColorManager.textFormColor,
                        border: Border.all(
                            color: ColorManager.textFormColor, width: 2),
                      ),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SfDateRangePicker(
                                  onSubmit: (v) {
                                    cubit.selectedDate =
                                        DateFormat("MM/dd/yyyy").format(
                                            DateTime.parse(v.toString()));

                                    Navigator.pop(context);
                                  },
                                  controller: cubit.dateController,
                                  confirmText: 'done',
                                  cancelText: 'cancel',
                                  showActionButtons: true,
                                  initialDisplayDate: DateTime.now(),
                                  minDate: DateTime.now(),
                                  onCancel: () {
                                    Navigator.pop(context);
                                  },
                                  onSelectionChanged:
                                      (DateRangePickerSelectionChangedArgs
                                          arg) {
                                    cubit.onSelectionChanged(
                                      args: arg,
                                    );
                                  },
                                  selectionMode:
                                      DateRangePickerSelectionMode.single,
                                );
                              });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextCustom(
                              text: cubit.selectedDate!,
                              color: ColorManager.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                            SvgPicture.asset(
                              'assets/icons/calender.svg',
                              width: 24.w,
                              height: 24.h,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s16,
                    ),
                    const TextCustom(
                      text: 'Reason',
                      color: ColorManager.textFormLabelColor,
                    ),
                    SizedBox(
                      height: AppSize.s4.h,
                    ),
                    Platform.isAndroid
                        ? TextFormFieldCustom(
                            controller: cubit.daysController,
                            keyboardType: TextInputType.number,
                            validate: (validate) {
                              if (validate!.isEmpty) {
                                return 'Please Enter the Reason';
                              }
                              return null;
                            })
                        : Expanded(
                            child: SizedBox(
                              height: AppSize.s100.h,
                              child: CupertinoTextFormFieldRow(
                                controller: cubit.daysController,
                                decoration: BoxDecoration(
                                  color: ColorManager.textFormColor,
                                  //floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  border: Border.all(
                                    color: ColorManager.textFormColor,
                                    width: AppSize.s1_5.w,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s8.r),
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        color: ColorManager.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: FontSize.s14.sp),
                                showCursor: true,
                                padding: EdgeInsets.symmetric(
                                  vertical: AppPadding.p16.h,
                                  horizontal: AppPadding.p16.w,
                                ),
                                validator: (validate) {
                                  if (validate!.isEmpty) {
                                    return 'Please Enter the Reason';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                maxLines: null,
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: AppSize.s16,
                    ),
                    const TextCustom(
                      text: 'Attachment',
                      color: ColorManager.textFormLabelColor,
                    ),
                    SizedBox(
                      height: AppSize.s4.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: ColorManager.textFormColor,
                        border: Border.all(
                            color: ColorManager.textFormColor, width: 2),
                      ),
                      child: InkWell(
                        onTap: () async {
                          cubit.pickFileFromDevice();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextCustom(
                              text: cubit.fileName ?? "File Name",
                              color: ColorManager.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                            SvgPicture.asset(
                              'assets/icons/attachment.svg',
                              width: 24.w,
                              height: 24.h,
                              // ignore: deprecated_member_use
                              color: const Color(0xff3D8BD3),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s16,
                    ),
                    const Spacer(),
                    state is CreateTimeOffLoading
                        ? Center(
                            child: CupertinoActivityIndicator(
                              color: ColorManager.primary,
                              radius: AppSize.s16.r,
                            ),
                          )
                        : ElevatedButtonCustom(
                            text: 'Save',
                            fontWeight: FontWeight.w500,
                            fontSize: FontSize.s18.sp,
                            onPressed: () async {
                              if (cubit.formKey.currentState!.validate()) {
                                // ProfileCubit.get(context)..getEmployeesFun();
                                cubit.createTimeOffFun();
                                cubit.formKey.currentState!.reset();
                              }
                            })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
