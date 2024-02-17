import 'package:Attendace/core/utils/constants_manager.dart';
import 'package:Attendace/core/utils/font_manager.dart';
import 'package:Attendace/core/utils/routes_manager.dart';
import 'package:Attendace/core/widgets/component.dart';
import 'package:Attendace/features/create_request/presentation/controller/apply_request_cubit.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/media_query_values.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../controller/apply_request_state.dart';

class ApplyRequestScreen extends StatefulWidget {
  const ApplyRequestScreen({super.key});

  @override
  State<ApplyRequestScreen> createState() => _ApplyRequestScreenState();
}

class _ApplyRequestScreenState extends State<ApplyRequestScreen> {
  @override
  Widget build(BuildContext context) {
    // List of items in our dropdown menu
    var items = [
      'Punch in',
      'Punch out',
      'Holiday',
      'Leave Request',
    ];
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(text: 'Apply Request'),
      body: BlocConsumer<ApplyRequestCubit, ApplyRequestState>(
        listener: (context, state) {
          if (state is ApplyRequestSuccess) {
            AppConstants.admin
                ? navigatorAndRemove(context, Routes.mainRouteAdmin)
                : navigatorAndRemove(context, Routes.mainRoute);
          } else if (state is ApplyRequestError) {
            SnackBar snackBar =
                SnackBar(content: Text(state.message.toString()));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          var cubit = ApplyRequestCubit.get(context);
          return Padding(
            padding: EdgeInsets.all(AppPadding.p16.r),
            child: SafeArea(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextCustom(
                      fontSize: FontSize.s14.sp,
                      text: 'Type',
                      color: ColorManager.textFormLabelColor,
                    ),
                    const SizedBox(
                      height: AppSize.s4,
                    ),
                    DropdownButtonHideUnderline(
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorManager.textFormColor,
                            borderRadius: BorderRadius.circular(AppSize.s8.r)),
                        width: context.width / 1.1,
                        height: AppSize.s50.h,
                        child: InkWell(
                          onTap: () {
                            showCupertinoModalPopup<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: AppSize.s100.h * 3,
                                    padding: const EdgeInsets.only(top: 6.0),
                                    color: CupertinoColors.white,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: DefaultTextStyle(
                                            style: const TextStyle(
                                              color: CupertinoColors.black,
                                              fontSize: 22.0,
                                            ),
                                            child: GestureDetector(
                                              // Blocks taps from propagating to the modal sheet and popping.
                                              onTap: () {},
                                              child: SafeArea(
                                                top: false,
                                                child: CupertinoPicker(
                                                  scrollController:
                                                      FixedExtentScrollController(
                                                          initialItem: 6),
                                                  magnification: 1.5,
                                                  backgroundColor: Colors.white,
                                                  itemExtent: 30,
                                                  //height of each item
                                                  looping: false,

                                                  children: List.generate(
                                                      items.length,
                                                      (index) => TextCustom(
                                                          color: ColorManager
                                                              .primary,
                                                          fontSize:
                                                              FontSize.s14.sp,
                                                          textAlign:
                                                              TextAlign.center,
                                                          text: items[index])),
                                                  onSelectedItemChanged:
                                                      (index) {
                                                    var item = switch (index) {
                                                      0 => items[0],
                                                      1 => items[1],
                                                      2 => items[2],
                                                      3 => items[3],
                                                      _ => items[
                                                          0], //Default value
                                                    };
                                                    cubit.typeFun(item);

                                                    // setState(() {
                                                    //   selectItem=value.toString();
                                                    // });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ElevatedButtonCustom(
                                          fontSize: FontSize.s14.sp,
                                          text: 'Done',
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: TextCustom(
                            fontSize: FontSize.s14.sp,
                            text: cubit.selectedValue.isNotEmpty
                                ? cubit.selectedValue
                                : 'Select Type',
                            color: cubit.checkType.isNotEmpty
                                ? ColorManager.secondary
                                : ColorManager.textFormIconColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),

                    // Material(
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton2(
                    //       isExpanded: true,
                    //       hint: Row(
                    //         children: [
                    //           Expanded(
                    //             child: TextCustom(
                    //               text: cubit.selectedValue.isNotEmpty
                    //                   ? cubit.selectedValue
                    //                   : 'Select Type',
                    //               color: cubit.checkType.isNotEmpty
                    //                   ? ColorManager.secondary
                    //                   : ColorManager.textFormIconColor,
                    //               overflow: TextOverflow.ellipsis,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       items: items
                    //           .map((item) => DropdownMenuItem<String>(
                    //         value: item,
                    //         child: TextCustom(
                    //           text: item,
                    //           overflow: TextOverflow.ellipsis,
                    //         ),
                    //       ))
                    //           .toList(),
                    //       value: selectedValue,
                    //       onChanged: (value) {
                    //         // 'check_in',
                    //         // 'check_out',
                    //         // 'holiday',
                    //         // 'leave_of_request',
                    //         cubit.typeFun(value!);
                    //       },
                    //       buttonStyleData: ButtonStyleData(
                    //         height: 50.h,
                    //         width: context.width,
                    //         padding:  EdgeInsets.only(left: 14.w, right: 14.w),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(AppSize.s10.r),
                    //           border: Border.all(
                    //             color: ColorManager.textFormColor,
                    //           ),
                    //           color: ColorManager.textFormColor,
                    //         ),
                    //         elevation: 0,
                    //       ),
                    //       iconStyleData: IconStyleData(
                    //         icon: Icon(
                    //           Icons.arrow_forward_ios_outlined,
                    //         ),
                    //         iconSize: AppSize.s14.r,
                    //         iconEnabledColor: ColorManager.secondary,
                    //         iconDisabledColor: ColorManager.textFormLabelColor,
                    //       ),
                    //       dropdownStyleData: DropdownStyleData(
                    //           maxHeight: AppSize.s100.h*2,
                    //           width: AppSize.s100.w*2,
                    //           padding: null,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(AppSize.s10.r),
                    //             color: ColorManager.textFormColor,
                    //           ),
                    //           elevation: 8,
                    //           offset: const Offset(-20, 0),
                    //           scrollbarTheme: ScrollbarThemeData(
                    //             radius:  Radius.circular(AppSize.s10.r),
                    //             thickness: MaterialStateProperty.all(6),
                    //             thumbVisibility: MaterialStateProperty.all(true),
                    //           )),
                    //       menuItemStyleData:  MenuItemStyleData(
                    //         height: AppSize.s40.h,
                    //         padding: EdgeInsets.only(left: 14.w, right: 14.w),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: AppSize.s16,
                    ),
                    TextCustom(
                      fontSize: FontSize.s14.sp,
                      text: 'Reason',
                      color: ColorManager.textFormLabelColor,
                    ),
                    SizedBox(
                      height: AppSize.s4.h,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: cubit.messageController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: ColorManager.textFormColor,
                          isDense: true,
                          //floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s8.r),
                            borderSide: BorderSide(
                              color: ColorManager.textFormColor,
                              width: AppSize.s1_5.w,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s8.r),
                            borderSide: BorderSide(
                              color: ColorManager.textFormColor,
                              width: AppSize.s1_5.w,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: AppPadding.p16,
                            horizontal: AppPadding.p16,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s8.r),
                            borderSide: BorderSide(
                              color: ColorManager.textFormColor,
                              width: AppSize.s1_5.w,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s8.r),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: AppSize.s1_5.w,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s8.r),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          suffixIconColor: ColorManager.textFormIconColor,
                          focusColor: ColorManager.textFormColor,

                          labelStyle: TextStyle(
                            color: ColorManager.grey,
                            fontSize: AppSize.s16.sp,
                          ),
                          floatingLabelStyle: TextStyle(
                            color: ColorManager.primary,
                            fontSize: AppSize.s16.sp,
                          ),
                        ),
                        validator: (validate) {
                          if (validate!.isEmpty) {
                            return 'Please Enter the reason';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        maxLines: null,
                      ),
                    ),
                    state is ApplyRequestLoading
                        ? CupertinoActivityIndicator(
                            color: ColorManager.primary,
                            radius: AppSize.s16.r,
                          )
                        : ElevatedButtonCustom(
                            text: 'Submit The Request',
                            fontWeight: FontWeight.w500,
                            fontSize: FontSize.s18.sp,
                            onPressed: () async {
                              if (cubit.formKey.currentState!.validate() &&
                                  cubit.checkType.isNotEmpty) {
                                // ProfileCubit.get(context)..getEmployeesFun();
                                cubit.applyRequest();
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
