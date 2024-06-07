// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final bool isRegister;

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
      this.validate,
      this.keyboardType,
      this.maxDigit = 100,
      this.onChanged,
      this.textInputAction,
      this.onTab,
      this.isRegister = false,
      this.onSaved,
      this.onEditingComplete,
      this.focus,
      this.align = TextAlign.start,
      this.initial,
      this.enable,
      this.fillColor = ColorManager.white,
      this.boarderColor = ColorManager.white,
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
      style: Theme.of(context).textTheme.titleMedium,
      initialValue: initial,
      controller: controller,
      textInputAction: textInputAction ?? TextInputAction.done,
      onChanged: (value) {
        //onChanged!(value);
        onChanged != null ? onChanged!(value) : null;
      },
      onEditingComplete: onEditingComplete,

      obscureText: obSecure,
      validator: validate,

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
          borderRadius: BorderRadius.circular(AppSize.s8),
          borderSide: BorderSide(
            color: boarderColor!,
            width: AppSize.s1_5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
          borderSide: const BorderSide(
            color: ColorManager.white,
            width: AppSize.s1_5,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: padding!,
          horizontal: AppPadding.p16,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
          borderSide: BorderSide(
            color: boarderColor!,
            width: AppSize.s1_5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
          borderSide: const BorderSide(
            color: ColorManager.error,
            width: AppSize.s1_5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
          borderSide: const BorderSide(
            color: ColorManager.error,
          ),
        ),
        suffixIconColor: ColorManager.textFormIconColor,
        focusColor: ColorManager.white,

        prefixIcon: prefix
            ? Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: InkWell(
                  onTap: prefixOnPressed != null
                      ? () {
                          prefixOnPressed!();
                          // suffixOnPressed!();
                        }
                      : null,
                  child: isRegister
                      ? const Text("+971")
                      : SvgPicture.asset(
                          prefixIcon!,
                          height: AppSize.s20,
                        ),
                ),
              )
            : null,
        suffixIcon: suffix
            ? Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: InkWell(
                  onTap: suffixOnPressed != null
                      ? () {
                          suffixOnPressed!();
                          // suffixOnPressed!();
                        }
                      : null,
                  child: SvgPicture.asset(
                    suffixIcon!,
                    height: AppSize.s20,
                    color: ColorManager.purple,
                  ),
                ),
              )
            : null,
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(
          color: ColorManager.grey,
          fontSize: AppSize.s16,
        ),
        floatingLabelStyle: const TextStyle(
          color: ColorManager.primary,
          fontSize: AppSize.s16,
        ),
      ),
    );
  }
}
