import 'package:Attendace/core/utils/color_manager.dart';
import 'package:Attendace/core/utils/font_manager.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/utils/values_manager.dart';
import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:Attendace/core/widgets/text_custom/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/assets_manager.dart';

class HelpAndFeedbackScreen extends StatelessWidget {
  HelpAndFeedbackScreen({super.key});

  final List<String> icons = [
    IconsAssets.facebookIcon,
    IconsAssets.whatsappIcon,
    IconsAssets.instagramIcon,
    IconsAssets.twitterIcon,
    IconsAssets.youtubeIcon,
    IconsAssets.linkedinIcon,
  ];
  final List<String> links = [
    AppStrings.facebook,
    AppStrings.whatsapp,
    AppStrings.instagram,
    AppStrings.twitter,
    AppStrings.youtube,
    AppStrings.linkedin,
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        appBarCustom: const AppBarCustom(
          text: AppStrings.helpsFeedback,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: SafeArea(
            child: Column(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Image.asset(
                      ImageAssets.logoImg,
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                TextCustom(
                  text: 'Social Media',
                  color: ColorManager.secondary,
                  fontSize: FontSize.s18,
                  fontWeight: FontWeight.w600,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                      icons.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: InkWell(
                                onTap: () async {
                                  await launchInBrowser(
                                      Uri.parse(links[index]));
                                },
                                child: SvgPicture.asset(
                                  icons[index],
                                  height: AppSize.s40 * 1.3,
                                )),
                          )),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
