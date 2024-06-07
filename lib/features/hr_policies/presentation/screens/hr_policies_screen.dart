import 'package:Attendace/core/utils/color_manager.dart';
import 'package:Attendace/core/utils/values_manager.dart';
import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/features/hr_policies/presentation/controller/cubit.dart';
import 'package:Attendace/features/hr_policies/presentation/controller/states.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/strings_manager.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';

class HrPoliciesScreen extends StatelessWidget {
  const HrPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HrPoliciesCubit()..getHrPolicies(),
      child: BlocBuilder<HrPoliciesCubit, HrPoliciesStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: const AppBarCustom(
              text: AppStrings.hrPolices,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSize.s40,
                vertical: AppSize.s20,
              ),
              child: state is HrPoliciesLoadingState
                  ? ShimmerCustom(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return BounceInLeft(
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSize.s8,
                                  vertical: AppSize.s10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: AppSize.s20,
                              ),
                          itemCount: 10),
                    )
                  : BlocProvider.of<HrPoliciesCubit>(context)
                          .hrPoliciesModel
                          .result
                          .responseModel
                          .isEmpty
                      ? const ErrorsWidget()
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            return BounceInLeft(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSize.s8,
                                  vertical: AppSize.s10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "# ${BlocProvider.of<HrPoliciesCubit>(context).hrPoliciesModel.result.responseModel[index].name}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(
                                              color: ColorManager.primary),
                                    ),
                                    const SizedBox(
                                      height: AppSize.s8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppSize.s16),
                                      child: Text(
                                        BlocProvider.of<HrPoliciesCubit>(
                                                context)
                                            .hrPoliciesModel
                                            .result
                                            .responseModel[index]
                                            .description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                color: ColorManager.darkGrey),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: AppSize.s20,
                              ),
                          itemCount: BlocProvider.of<HrPoliciesCubit>(context)
                              .hrPoliciesModel
                              .result
                              .responseModel
                              .length),
            ),
          );
        },
      ),
    );
  }
}
