import 'package:Attendace/core/widgets/error_widget.dart';
import 'package:Attendace/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:Attendace/features/myTimeOff/presentation/controller/myTimeOff_cubit.dart';
import 'package:Attendace/features/myTimeOff/presentation/controller/myTimeOff_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import 'userRequest_widget.dart';

class RefusedWidget extends StatelessWidget {
  const RefusedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MyTimeOffCubit>(context)..getMyTimeOffFun(),
      child: BlocConsumer<MyTimeOffCubit, MyTimeOffState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MyTimeOffCubit.get(context);

          return cubit.myTimeOffRefuse.isNotEmpty
              ? ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserRequestWidget(
                          iconPath: IconsAssets.emailIcon,
                          text: AppStrings.message,
                          subText: cubit.myTimeOffRefuse[index].holidayStatus,
                        ),
                        UserRequestWidget(
                            iconPath: IconsAssets.calenderIcon,
                            text: AppStrings.date,
                            subText: DateFormat('EEE, MMM dd, yyyy').format(
                                DateTime.parse(
                                    cubit.myTimeOffRefuse[index].start))),
                        UserRequestWidget(
                            iconPath: IconsAssets.calenderIcon,
                            text: AppStrings.date,
                            subText: DateFormat('EEE, MMM dd, yyyy').format(
                                DateTime.parse(
                                    cubit.myTimeOffRefuse[index].end))),
                        UserRequestWidget(
                          iconPath: IconsAssets.distanceIcon,
                          text: AppStrings.distance,
                          subText: cubit.myTimeOffRefuse[index].description,
                        ),
                        UserRequestWidget(
                          iconPath: IconsAssets.clockIcon,
                          text: AppStrings.status,
                          subText: cubit.myTimeOffRefuse[index].state,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppStrings.users,
                          style: TextStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s18,
                              fontWeight: FontWeight.w600),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Row(
                                  children: [
                                    Expanded(
                                      child: UserRequestWidget(
                                        iconPath: IconsAssets.personIcon,
                                        text: AppStrings.admin,
                                        subText: cubit.myTimeOff[index]
                                            .approvers[index].userName,
                                      ),
                                    ),
                                    UserRequestWidget(
                                      iconPath: "",
                                      text: AppStrings.admin,
                                      subText: cubit.myTimeOff[index]
                                          .approvers[index].state,
                                    ),
                                  ],
                                ),
                            itemCount: cubit.myTimeOff[index].approvers.length),
                      ],
                    ),
                  ),
                  itemCount: cubit.myTimeOffRefuse.length,
                )
              : state is GetMyTimeOffLoading
                  ? ShimmerCustom(
                      child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => const Column(
                        children: [
                          UserRequestWidget(
                            iconPath: IconsAssets.emailIcon,
                            text: AppStrings.message,
                            subText: 'Loading.....',
                          ),
                          UserRequestWidget(
                            iconPath: IconsAssets.clockIcon,
                            text: AppStrings.status,
                            subText: 'Loading.....',
                          ),
                        ],
                      ),
                      itemCount: 2,
                    ))
                  : ErrorsWidget(
                      onPress: () {
                        cubit.getMyTimeOffFun();
                      },
                    );
        },
      ),
    );
  }
}
