import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/color_manager.dart';
import '../../utils/values_manager.dart';

class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validate;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final bool obSecure;
  final String? prefixIcon;
  final bool prefix;
  final String? suffixIcon;
  final bool suffix;
  final Function? suffixOnPressed;
  final Function? prefixOnPressed;
  final TextInputType? keyboardType;
  final int maxDigit;
  final Function? onChanged;
  final TextInputAction? textInputAction;
  final Function? onTab;
  final FocusNode? focus;
  final TextAlign align;
  final String? initial;
  final bool? enable;
  final double? padding;
  final int? maxLines;
  final Color? fillColor;
  final Color? boarderColor;

  const TextFormFieldCustom(
      {super.key,
      this.controller,
      this.label,
      this.hint,
      this.obSecure = false,
      this.prefixIcon = '',
      this.prefix = false,
      this.suffixIcon = '',
      this.suffix = false,
      this.suffixOnPressed,
      this.prefixOnPressed,
      required this.validate,
      this.keyboardType,
      this.maxDigit = 100,
      this.onChanged,
      this.textInputAction,
      this.onTab,
      this.onSaved,
      this.onEditingComplete,
      this.focus,
      this.align = TextAlign.start,
      this.initial,
      this.enable,
      this.fillColor = ColorManager.textFormColor,
      this.boarderColor = ColorManager.textFormColor,
      this.padding = 16.0,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4),
      maxLines: maxLines ?? 1,
      textAlignVertical: TextAlignVertical.center,
      textAlign: align,
      focusNode: focus,
      // autofocus: true,
      enabled: enable,
      initialValue: initial,
      controller: controller,
      textInputAction: textInputAction ?? TextInputAction.done,
      onChanged: (value) {
        //onChanged!(value);
        onChanged != null ? onChanged!(value) : null;
      },
      onEditingComplete: onEditingComplete,

      obscureText: obSecure,
      validator: (value) {
        return validate!(value);
      },
      onSaved: onSaved,
      keyboardType: keyboardType,
      cursorColor: ColorManager.primary,
      onTap: () {
        onTab != null ? onTab!() : null;
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxDigit),
      ],
      //maxLength: maxDigit,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        isDense: true,
        //floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8.r),
          borderSide: BorderSide(
            color: boarderColor!,
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
        contentPadding: EdgeInsets.symmetric(
          vertical: padding!,
          horizontal: AppPadding.p16.w,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8.r),
          borderSide: BorderSide(
            color: boarderColor!,
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

        prefixIcon: prefix
            ? Padding(
                padding: EdgeInsets.all(AppPadding.p16.r),
                child: InkWell(
                  onTap: prefixOnPressed != null
                      ? () {
                          prefixOnPressed!();
                          // suffixOnPressed!();
                        }
                      : null,
                  child: SvgPicture.asset(
                    prefixIcon!,
                    height: AppSize.s20.h,
                  ),
                ),
              )
            : null,
        suffixIcon: suffix
            ? Padding(
                padding: EdgeInsets.all(AppPadding.p16.r),
                child: InkWell(
                  onTap: suffixOnPressed != null
                      ? () {
                          suffixOnPressed!();
                          // suffixOnPressed!();
                        }
                      : null,
                  child: SvgPicture.asset(
                    suffixIcon!,
                    height: AppSize.s20.h,
                  ),
                ),
              )
            : null,
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(
          color: ColorManager.grey,
          fontSize: AppSize.s16.sp,
        ),
        floatingLabelStyle: TextStyle(
          color: ColorManager.primary,
          fontSize: AppSize.s16.sp,
        ),
      ),
    );
  }
}
