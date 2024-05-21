import 'package:Attendace/core/utils/font_manager.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager.dart';

class DropDownWidget extends StatelessWidget {
  DropDownWidget({
    super.key,
    required this.label,
  });
  final List<String> items = ["demo 1", "demo 2", "demo 3"];
  final String label;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                5,
              ),
              border: Border.all()),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        hint: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: ColorManager.darkGrey,
                      fontSize: FontSize.s16,
                    ),
              ),
            ),
          ],
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                      fontFamily: FontConstants.fontFamily,
                      fontSize: FontSize.s14,
                      color: ColorManager.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {},
      ),
    );
  }
}
