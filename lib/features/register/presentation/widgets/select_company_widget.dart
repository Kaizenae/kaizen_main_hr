// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:Attendace/core/utils/media_query_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class SelectCompanyWidget extends StatelessWidget {
  const SelectCompanyWidget({
    super.key,
    required this.registerCubit,
  });
  final registerCubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextCustom(
          fontSize: FontSize.s14,
          text: AppStrings.company,
          textAlign: TextAlign.start,
          color: ColorManager.white,
        ),
        const SizedBox(
          height: AppSize.s4,
        ),
        Material(
          child: DropdownButtonHideUnderline(
            child: registerCubit
                    .companiesDataModel.result.responseModel.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(
                        color: ColorManager.textFormColor,
                        borderRadius: BorderRadius.circular(AppSize.s8)),
                    width: context.width / 1.1,
                    height: AppSize.s50,
                    child: InkWell(
                      onTap: () {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: AppSize.s100 * 3,
                              padding: const EdgeInsets.only(top: 6.0),
                              color: CupertinoColors.white,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: DefaultTextStyle(
                                      style: const TextStyle(
                                        color: CupertinoColors.black,
                                        fontSize: 18.0,
                                      ),
                                      child: GestureDetector(
                                        // Blocks taps from propagating to the modal sheet and popping.
                                        onTap: () {},
                                        child: SafeArea(
                                          top: false,
                                          child: CupertinoPicker(
                                            magnification: 1.5,
                                            backgroundColor: Colors.white,
                                            itemExtent: 30,
                                            //height of each item
                                            looping: false,

                                            children: List.generate(
                                              registerCubit.companiesDataModel
                                                  .result.responseModel.length,
                                              (index) => Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: TextCustom(
                                                    color: ColorManager.primary,
                                                    fontSize: FontSize.s14,
                                                    textAlign: TextAlign.center,
                                                    text: registerCubit
                                                            .companiesDataModel
                                                            .result
                                                            .responseModel[
                                                                index]
                                                            .companyName ??
                                                        AppStrings
                                                            .selectTheCompany,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onSelectedItemChanged: (index) {
                                              registerCubit.changeCompany(
                                                  registerCubit
                                                      .companiesDataModel
                                                      .result
                                                      .responseModel[index]);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButtonCustom(
                                      text: AppStrings.done,
                                      fontSize: FontSize.s14,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: TextCustom(
                        color: ColorManager.primary,
                        fontSize: FontSize.s14,
                        text: registerCubit.companyName.isEmpty
                            ? AppStrings.selectTheCompany
                            : registerCubit.companyName,
                      ),
                    ),
                  )
                : ShimmerCustom(
                    child: SizedBox(
                      height: AppSize.s50,
                      child: DropdownMenu(
                        width: context.width / 1.1,
                        hintText: AppStrings.selectTheCompany,
                        key: const Key('2'),
                        inputDecorationTheme: InputDecorationTheme(
                          filled: true,
                          fillColor: ColorManager.textFormColor,
                          isDense: true,
                          //floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s8),
                            borderSide: const BorderSide(
                              color: ColorManager.textFormColor,
                              width: AppSize.s1_5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s8),
                            borderSide: const BorderSide(
                              color: ColorManager.textFormColor,
                              width: AppSize.s1_5,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: AppPadding.p8,
                            horizontal: AppPadding.p16,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s8),
                            borderSide: const BorderSide(
                              color: ColorManager.textFormColor,
                              width: AppSize.s1_5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s8),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: AppSize.s1_5,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s8),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          suffixIconColor: ColorManager.textFormIconColor,
                          focusColor: ColorManager.textFormColor,
                        ),
                        enabled: false,
                        trailingIcon: const Icon(
                          Icons.arrow_drop_down_rounded,
                          color: ColorManager.primary,
                        ),
                        dropdownMenuEntries: const [],
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
