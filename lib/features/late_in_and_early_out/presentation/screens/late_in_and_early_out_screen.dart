import 'package:Attendace/core/utils/media_query_values.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/core/widgets/app_bar/app_bar_custom.dart';
import 'package:Attendace/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:Attendace/features/late_in_and_early_out/presentation/controller/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../myLoans/presentation/widgets/userRequest_widget.dart';
import '../controller/cubit.dart';
import '../widget/early_and_late_list.dart';
import 'create_late_in_and_early_out_screen.dart';

class LateInAndEarlyOutScreen extends StatelessWidget {
  const LateInAndEarlyOutScreen({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EarlyOutLateInCubit()
        ..getEarlyOut()
        ..getLateIn(),
      child: ScaffoldCustom(
          appBarCustom: AppBarCustom(
            text: title,
          ),
          body: BlocBuilder<EarlyOutLateInCubit, EarlyOutLateInStates>(
            builder: (context, state) {
              return Column(
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
                  state is GetLateInEarlyOutLoadingState
                      ? ShimmerCustom(
                          child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => const Column(
                            children: [
                              UserRequestWidget(
                                iconPath: IconsAssets.emailIcon,
                                text: AppStrings.message,
                                subText: '',
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
                      : Expanded(
                          child: EarlyAndLateList(
                          title: title,
                          list: title == AppStrings.lateInRequest
                              ? BlocProvider.of<EarlyOutLateInCubit>(context)
                                  .lateinModel
                                  .result
                                  .responseModel
                              : BlocProvider.of<EarlyOutLateInCubit>(context)
                                  .earlyOutModel
                                  .result
                                  .responseModel,
                        ))
                ],
              );
            },
          )),
    );
  }
}
