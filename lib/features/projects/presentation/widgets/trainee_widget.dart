import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';

class TraineeWidget extends StatelessWidget {
  const TraineeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: ColorManager.lightGrey2,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Column(
        children: [
          Text(
            AppStrings.idNumber,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            "3456789",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: ColorManager.black,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              "الاسم : أحمد سعيد مرسي ابراهيم",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Email : A.Saed@kaizenae.com",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 16, color: ColorManager.primary),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Gender : Male",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: ColorManager.black,
                      ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "Age : 25",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: ColorManager.black,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Issuance Date : 01/01/2025",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Nationality : Egyption",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: FontSize.s14,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
