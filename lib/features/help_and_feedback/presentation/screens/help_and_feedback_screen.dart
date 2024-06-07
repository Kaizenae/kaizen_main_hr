import 'package:Attendace/core/utils/color_manager.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/utils/values_manager.dart';
import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
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
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p16, horizontal: 40),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: 3 / 1,
                      child: Image.asset(
                        ImageAssets.homeIconImg,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s30,
                  ),
                  Text(
                    "PO Box: Dubai, Dubai, UAE.",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await launchInBrowser(Uri.parse("tel:+971 56 682 8836"));
                    },
                    child: Text(
                      "Contact number : +971 56 682 8836",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: ColorManager.darkGrey,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await launchInBrowser(
                          Uri.parse("mailto:sales@kaizenae.com"));
                    },
                    child: Text(
                      "Email : sales@kaizenae.com",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Wrap(
                    spacing: 16,
                    children: [
                      InkWell(
                          onTap: () async {
                            await launchInBrowser(
                                Uri.parse("https://www.kaizenae.com"));
                          },
                          child: const Image(
                            height: AppSize.s40 * 1.3,
                            width: AppSize.s40 * 1.3,
                            image: AssetImage(
                              ImageAssets.webIcon,
                            ),
                          )),
                      InkWell(
                        onTap: () async {
                          await launchInBrowser(Uri.parse(
                              "https://www.instagram.com/kaizen_principles__?igsh=dnNuZW54bWo5cTdn"));
                        },
                        child: SvgPicture.asset(
                          IconsAssets.instagramIcon,
                          height: AppSize.s40 * 1.3,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await launchInBrowser(
                              Uri.parse("https://wa.me/+971566828836"));
                        },
                        child: SvgPicture.asset(
                          IconsAssets.whatsappIcon,
                          height: AppSize.s40 * 1.3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
