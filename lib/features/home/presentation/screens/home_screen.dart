// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:Attendace/core/utils/color_manager.dart';
import 'package:Attendace/core/utils/font_manager.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/widgets/snack_bar/snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../late_in_and_early_out/presentation/screens/late_in_and_early_out_screen.dart';
import '../../../profile/presentation/cubit/profile_cubit.dart';
import '../../../profile/presentation/cubit/profile_state.dart';
import '../controller/home_cubit.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../controller/home_state.dart';
import '../widget/feature_item_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      backgroundColor: ColorManager.primary,
      body: BlocProvider.value(
        value: BlocProvider.of<HomeCubit>(context),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is CheckInAndOutSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                  message:
                      state.punchInOutEntity.resultEntity.message.toString(),
                  context: context));
            } else if (state is CheckInAndOutError) {
              ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                  message: state.message.toString(), context: context));
            }
          },
          builder: (context, state) {
            var homeCubit = HomeCubit.get(context);
            return SafeArea(
                child: SizedBox(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: ColorManager.scaffoldColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<ProfileCubit>(context)
                            ..getEmployeeFun(),
                          child: BlocBuilder<ProfileCubit, ProfileState>(
                            builder: (context, state) {
                              return state is GetEmployeeSuccess
                                  ? state.employeeEntity.resultEntity
                                          .response[0].photo.isEmpty
                                      ? Container(
                                          width: 65,
                                          height: 65,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                ImageAssets.userPhotoImg,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          width: 65,
                                          height: 65,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: MemoryImage(
                                                base64Decode(
                                                  state
                                                      .employeeEntity
                                                      .resultEntity
                                                      .response[0]
                                                      .photo,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                  : Container(
                                      width: 65,
                                      height: 65,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            ImageAssets.userPhotoImg,
                                          ),
                                        ),
                                      ),
                                    );
                            },
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                ColorManager.scaffoldColor),
                          ),
                          color: ColorManager.primary,
                          onPressed: () {
                            HomeCubit.get(context).changePunchInAndPunchOut();
                          },
                          icon: Row(
                            children: [
                              const Icon(
                                Icons.fingerprint,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                HomeCubit.get(context).isPunchIn
                                    ? AppStrings.punchOut
                                    : AppStrings.punchIn,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: FontConstants.fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(AppPadding.p16),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: ColorManager.scaffoldColor,
                      ),
                      child: ListView.separated(
                        itemBuilder: (context, index) => FeatureItemWidget(
                          backgroundImg:
                              AppConstants.featureList[index].backgroundImg,
                          title: AppConstants.featureList[index].title,
                          icon: AppConstants.featureList[index].icon,
                          onTap: () {
                            if (AppConstants.featureList[index].route.isEmpty) {
                            } else if (AppConstants.featureList[index].route ==
                                "Late In") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LateInAndEarlyOutScreen(
                                    title: AppStrings.lateInRequest,
                                  ),
                                ),
                              );
                            } else if (AppConstants.featureList[index].route ==
                                "Early Out") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LateInAndEarlyOutScreen(
                                    title: AppStrings.earlyOutRequest,
                                  ),
                                ),
                              );
                            } else {
                              Navigator.pushNamed(
                                context,
                                AppConstants.featureList[index].route,
                              );
                            }
                          },
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                        itemCount: AppConstants.featureList.length,
                      ),
                    ),
                  ),
                ],
              ),
            ));
          },
        ),
      ),
    );
  }
}
