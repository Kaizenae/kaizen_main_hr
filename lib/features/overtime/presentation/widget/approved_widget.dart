// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager.dart';

class ApprovedWidget extends StatelessWidget {
  ApprovedWidget({
    super.key,
  });

  var state;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20),
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: ColorManager.lightGrey.withOpacity(.1),
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "06:00 - 10:00",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 16),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "Going on a vacation ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "Oct 12, 2022",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 14),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.green.withOpacity(.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Approved",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: ColorManager.white,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "Akhil Retnan - New",
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
      itemCount: 10,
    );
  }
}
