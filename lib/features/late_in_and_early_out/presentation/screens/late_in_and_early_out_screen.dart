import 'dart:developer';
import 'dart:io';

import 'package:Attendace/core/utils/font_manager.dart';
import 'package:Attendace/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:Attendace/core/widgets/text_custom/text_custom.dart';
import 'package:Attendace/core/widgets/text_form_field/text_form_field_custom.dart';
import 'package:Attendace/features/late_in_and_early_out/presentation/controller/cubit.dart';
import 'package:Attendace/features/late_in_and_early_out/presentation/controller/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';

class LateInEarlyOutScreen extends StatefulWidget {
  const LateInEarlyOutScreen({super.key, required this.title});
  final String title;

  @override
  State<LateInEarlyOutScreen> createState() => _LateInEarlyOutScreenState();
}

class _LateInEarlyOutScreenState extends State<LateInEarlyOutScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: AppBarCustom(text: widget.title),
      body: BlocProvider(
        create: (context) => EarlyOutLateInCubit(),
        child: BlocConsumer<EarlyOutLateInCubit, EarlyOutLateInStates>(
          listener: (context, state) {
            if (state is EarlyOutErrorState) {
              SnackBar snackBar =
                  SnackBar(content: Text(state.message.toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (state is EarlyOutSuccessState) {
              SnackBar snackBar =
                  SnackBar(content: Text(state.message.toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (state is LateInSuccessState) {
              SnackBar snackBar =
                  SnackBar(content: Text(state.message.toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (state is LateInErrorState) {
              SnackBar snackBar =
                  SnackBar(content: Text(state.message.toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            var cubit = BlocProvider.of<EarlyOutLateInCubit>(context);
            log(state.toString());

            return Padding(
              padding: EdgeInsets.all(AppPadding.p16.r),
              child: SafeArea(
                child: Form(
                  key: formKey,
                  child: CustomScrollView(slivers: [
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
                              SizedBox(
                                height: AppSize.s10.h,
                              ),

                              TextCustom(
                                fontSize: FontSize.s14.sp,
                                text: 'Date',
                                color: ColorManager.textFormLabelColor,
                              ),
                              SizedBox(
                                height: AppSize.s8.h,
                              ),
                              //Date
                              Container(
                                padding: EdgeInsets.all(12.sp),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: ColorManager.textFormColor,
                                  border: Border.all(
                                      color: ColorManager.textFormColor,
                                      width: 2),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return SfDateRangePicker(
                                            onSubmit: (v) {
                                              cubit.selectedDate =
                                                  DateFormat("MM/dd/yyyy")
                                                      .format(DateTime.parse(
                                                          v.toString()));
                                              log(cubit.selectedDate
                                                  .toString());
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
                                                DateRangePickerSelectionMode
                                                    .single,
                                          );
                                        });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                              SizedBox(
                                height: AppSize.s20.h,
                              ),
                              TextCustom(
                                fontSize: FontSize.s14.sp,
                                text: 'Reason',
                                color: ColorManager.textFormLabelColor,
                              ),
                              SizedBox(
                                height: AppSize.s8.h,
                              ),
                              Platform.isAndroid
                                  ? TextFormFieldCustom(
                                      controller: cubit.reasonController,
                                      keyboardType: TextInputType.text,
                                      validate: (validate) {
                                        if (validate!.isEmpty) {
                                          return 'Please Enter the Reason';
                                        }
                                        return null;
                                      })
                                  : SizedBox(
                                      height: AppSize.s100.h,
                                      child: CupertinoTextFormFieldRow(
                                        controller: cubit.reasonController,
                                        decoration: BoxDecoration(
                                          color: ColorManager.textFormColor,
                                          //floatingLabelBehavior: FloatingLabelBehavior.auto,
                                          border: Border.all(
                                            color: ColorManager.textFormColor,
                                            width: AppSize.s1_5.w,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              AppSize.s8.r),
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
                              SizedBox(
                                height: AppSize.s20.h,
                              ),
                              TextCustom(
                                fontSize: FontSize.s14.sp,
                                text: 'Attachment',
                                color: ColorManager.textFormLabelColor,
                              ),
                              SizedBox(
                                height: AppSize.s8.h,
                              ),
                              Container(
                                padding: EdgeInsets.all(12.sp),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: ColorManager.textFormColor,
                                  border: Border.all(
                                      color: ColorManager.textFormColor,
                                      width: 2),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    cubit.pickFileFromDevice();
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                            ],
                          )),
                          SizedBox(
                            height: AppSize.s20.h,
                          ),
                          SizedBox(
                            child: state is EarlyOutLoadingState ||
                                    state is LateInLoadingState
                                ? Center(
                                    child: CupertinoActivityIndicator(
                                      color: ColorManager.primary,
                                      radius: AppSize.s16.r,
                                    ),
                                  )
                                : ElevatedButtonCustom(
                                    text: 'Submit',
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSize.s18.sp,
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        if (widget.title ==
                                            AppStrings.lateInRequest) {
                                          cubit.lateIn();
                                        } else if (widget.title ==
                                            AppStrings.earlyOutRequest) {
                                          cubit.earlyOutRequest();
                                        }
                                      }
                                    }),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
