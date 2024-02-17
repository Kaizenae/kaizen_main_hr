import 'package:Attendace/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../text_custom/text_custom.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  final IconData? iconData;
  final String? text;
  final Function? onPressed;
  final List<Widget>? actions;
  final bool? isNull;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? centerTitle;
  final Widget? widget;
  final Widget? trailing;
  final Color? color;

  const AppBarCustom({
    super.key,
    this.iconData = Icons.arrow_back_ios_new_outlined,
    this.text = '',
    this.widget,
    this.onPressed,
    this.color = ColorManager.scaffoldColor,
    this.isNull = true,
    this.centerTitle = true,
    this.textAlign = TextAlign.center,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w600,
    this.actions,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      centerTitle: centerTitle,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      ),
      leading: isNull!
          ? InkWell(
              onTap: () {
                onPressed == null ? null : onPressed!();
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                'assets/icons/arrowLeft.svg',
                fit: BoxFit.scaleDown,
              ),
            )
          : widget,
      title: TextCustom(
        textAlign: textAlign!,
        text: text!,
        fontSize: fontSize!.sp,
        fontWeight: fontWeight!,
        color: Colors.black,
      ),
      actions: actions,
    );
  }
}
