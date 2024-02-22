import 'package:flutter/material.dart';

import '../utils/assets_manager.dart';

class ErrorsWidget extends StatelessWidget {
  final VoidCallback? onPress;

  const ErrorsWidget({super.key, this.onPress});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: AspectRatio(
      aspectRatio: 2 / 1.5,
      child: Image(
        image: AssetImage(
          ImageAssets.noDataImg,
        ),
      ),
    ));
    // return SingleChildScrollView(
    //   physics: const BouncingScrollPhysics(),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       const Center(
    //         child: Icon(
    //           Icons.warning_amber_rounded,
    //           color: ColorManager.primary,
    //           size: 100,
    //         ),
    //       ),
    //       Container(
    //         margin: const EdgeInsets.symmetric(vertical: 12),
    //         child: TextCustom(
    //             text: 'Something Went Wrong',
    //             color: Colors.black,
    //             fontSize: FontSize.s16,
    //             fontWeight: FontWeight.w700),
    //       ),
    //       TextCustom(
    //           text: 'Try again',
    //           color: ColorManager.grey1,
    //           fontSize: FontSize.s14,
    //           fontWeight: FontWeight.w500),
    //       Container(
    //         height: AppSize.s50,
    //         width: context.width * 0.55,
    //         margin: const EdgeInsets.symmetric(vertical: 15),
    //         child: ElevatedButtonCustom(
    //           text: 'Reload Screen',
    //           onPressed: () {
    //             if (onPress != null) {
    //               onPress!();
    //             }
    //           },
    //           fontSize: FontSize.s14,
    //         ),
    //       )
    //     ],
    //   ),
    // )
  }
}
