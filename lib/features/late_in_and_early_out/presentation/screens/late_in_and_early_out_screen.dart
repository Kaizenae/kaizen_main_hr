import 'package:Attendace/core/utils/media_query_values.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../myRequests/presentation/widgets/userRequest_widget.dart';
import 'create_late_in_and_early_out_screen.dart';

class LateInAndEarlyOutScreen extends StatelessWidget {
  const LateInAndEarlyOutScreen({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: AppBarCustom(
        text: title,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: AppSize.s16,
          ),
          Center(
            child: ElevatedButtonCustom(
              fontSize: FontSize.s14,
              colors: ColorManager.secondary,
              width: context.width / 1.6,
              text: 'Apply Request',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateLateInEarlyOutScreen(
                        title: title,
                      ),
                    ));
              },
            ),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: SizedBox(
                  child: Column(
                    children: [
                      UserRequestWidget(
                        iconPath: IconsAssets.emailIcon,
                        text: AppStrings.message,
                        subText: title,
                      ),
                      UserRequestWidget(
                          iconPath: IconsAssets.calenderIcon,
                          text: AppStrings.date,
                          subText: DateFormat('EEE, MMM dd, yyyy')
                              .format(DateTime.parse("2024-04-01 00:00:00"))),
                      const UserRequestWidget(
                        iconPath: IconsAssets.messageQuestionIcon,
                        text: AppStrings.message,
                        subText: "i am tired",
                      ),
                      const UserRequestWidget(
                        iconPath: IconsAssets.clockIcon,
                        text: AppStrings.status,
                        subText: "Approved",
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}
