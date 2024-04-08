import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../controller/attendance_cubit.dart';
import '../controller/attendance_state.dart';

class OddPunshOutScreen extends StatelessWidget {
  const OddPunshOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p12),
          margin: const EdgeInsets.symmetric(
              horizontal: AppPadding.p16, vertical: AppPadding.p12),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(AppSize.s10),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: TextCustom(
                          text: 'Date',
                          color: ColorManager.black,
                          fontSize: AppSize.s16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: TextCustom(
                          text: 'Punch out',
                          color: ColorManager.primary,
                          fontSize: AppSize.s16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                BlocProvider.value(
                  value: BlocProvider.of<AttendanceCubit>(context)
                    ..getOddPunchOut(),
                  child: BlocConsumer<AttendanceCubit, AttendanceState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return state is GetOddPunchOutSuccessState
                          ? AttendanceCubit.get(context)
                                  .oddPunchOutModel
                                  .result
                                  .responseModel
                                  .isEmpty
                              ? const ErrorsWidget()
                              : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: AppPadding.p12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: TextCustom(
                                              fontSize: FontSize.s14,
                                              text: DateFormat('dd , MMM')
                                                  .format(DateTime.parse(
                                                      AttendanceCubit.get(
                                                              context)
                                                          .oddPunchOutModel
                                                          .result
                                                          .responseModel[index]
                                                          .punchingTime)),
                                              color: ColorManager.black,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: TextCustom(
                                              fontSize: FontSize.s14,
                                              text: AttendanceCubit.get(context)
                                                          .oddPunchOutModel
                                                          .result
                                                          .responseModel[index]
                                                          .punchingTime !=
                                                      'false'
                                                  ? DateFormat('hh: mm a')
                                                      .format(DateTime.tryParse(
                                                              AttendanceCubit.get(
                                                                      context)
                                                                  .oddPunchOutModel
                                                                  .result
                                                                  .responseModel[
                                                                      index]
                                                                  .punchingTime)!
                                                          .add(const Duration(
                                                              hours:
                                                                  4))) // we need add duration about 4 hours to set time in UAE becuse we recive time in UTC time zone
                                                  : '00: 00: 00',
                                              color: ColorManager.primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  itemCount: AttendanceCubit.get(context)
                                      .oddPunchOutModel
                                      .result
                                      .responseModel
                                      .length,
                                )
                          : state is GetOddPunchOutLoadingState
                              ? ShimmerCustom(
                                  child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: AppPadding.p12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextCustom(
                                          fontSize: FontSize.s14,
                                          text: '20 sep',
                                          color: ColorManager.black,
                                        ),
                                        TextCustom(
                                          fontSize: FontSize.s14,
                                          text: '09:00 am',
                                          color: ColorManager.primary,
                                        ),
                                        TextCustom(
                                          fontSize: FontSize.s14,
                                          text: '06:00 pm',
                                          color: ColorManager.error,
                                        ),
                                      ],
                                    ),
                                  ),
                                  itemCount: 10,
                                ))
                              : const ErrorsWidget();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
