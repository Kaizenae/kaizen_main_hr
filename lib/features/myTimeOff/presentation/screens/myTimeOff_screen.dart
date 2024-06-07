// ignore_for_file: file_names

import 'package:Attendace/core/services/animation/slide_transtion.dart';
import 'package:Attendace/core/utils/font_manager.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:Attendace/core/widgets/tab_bar_custom/tab_bar_custom.dart';
import 'package:Attendace/features/create_timeOff/presentation/screens/create_timeOff_screen.dart';
import 'package:Attendace/features/myTimeOff/presentation/controller/myTimeOff_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/values_manager.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../controller/myTimeOff_state.dart';
import '../widgets/approved_widget.dart';
import '../widgets/pending_time_widget.dart';
import '../widgets/refuse_widget.dart';

class MyTimeOffScreen extends StatelessWidget {
  const MyTimeOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MyTimeOffCubit>(context)..getAllTimeOffValues(),
      child: ScaffoldCustom(
        appBarCustom: const AppBarCustom(
          text: AppStrings.myTimeOff,
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                BlocProvider.value(
                  value: BlocProvider.of<MyTimeOffCubit>(context)
                    ..getAllTimeOffValues(),
                  child: BlocBuilder<MyTimeOffCubit, MyTimeOffState>(
                    builder: (context, state) {
                      return SizedBox(
                        height: 125,
                        child: BlocProvider.of<MyTimeOffCubit>(context)
                                .allTimeOffValueModel
                                .result
                                .responseModel
                                .isNotEmpty
                            ? ListView.separated(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            40,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    padding:
                                        const EdgeInsets.all(AppPadding.p18),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorManager.lightGrey
                                              .withOpacity(.2),
                                          blurRadius: 10,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                      color: ColorManager.white,
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextCustom(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          text: BlocProvider.of<MyTimeOffCubit>(
                                                      context)
                                                  .allTimeOffNameAndValues[
                                              index]["timeOffName"],
                                          color: ColorManager.grey,
                                          fontSize: FontSize.s16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        Row(
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: TextCustom(
                                                text: BlocProvider
                                                            .of<MyTimeOffCubit>(
                                                                context)
                                                        .allTimeOffNameAndValues[
                                                    index]["timeOffValue"],
                                                color: ColorManager.black,
                                                fontSize: FontSize.s20,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: TextCustom(
                                                text: " / 40",
                                                color: ColorManager.darkGrey,
                                                fontSize: FontSize.s16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: TextCustom(
                                            text: AppStrings.days,
                                            color: ColorManager.darkGrey,
                                            fontSize: FontSize.s12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: AppSize.s14,
                                  );
                                },
                                itemCount:
                                    BlocProvider.of<MyTimeOffCubit>(context)
                                        .allTimeOffNameAndValues
                                        .length)
                            : Center(
                                child: Text(
                                  AppStrings.youDontHaveLeaveBalance,
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                              ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s16,
                ),
                const TabBarCustom(
                  widgets: [
                    PendingTimeWidget(),
                    ApprovedWidget(),
                    RefusedWidget(),
                  ],
                  myTabs: [
                    Tab(
                      text: AppStrings.pending,
                    ),
                    Tab(
                      text: AppStrings.approved,
                    ),
                    Tab(
                      text: AppStrings.rejected,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: ColorManager.primary,
          label: Row(
            children: [
              Text(
                AppStrings.apply,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.add,
                color: ColorManager.white,
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).push(
              SlideTranstion(
                page: const CreateTimeOffScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
