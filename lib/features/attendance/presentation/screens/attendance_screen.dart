import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/features/attendance/presentation/screens/all_attendance_screen.dart';
import 'package:Attendace/features/attendance/presentation/screens/odd_punch_in.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/tab_bar_custom/tab_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/attendance_cubit.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AttendanceCubit>(context),
      child: ScaffoldCustom(
        appBarCustom: const AppBarCustom(
          text: AppStrings.myAttendance,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: const SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                TabBarCustom(
                  widgets: [
                    AllAtendanceScreen(),
                    OddPunshInScreen(),
                  ],
                  myTabs: [
                    Tab(
                      text: AppStrings.allAtendance,
                    ),
                    Tab(
                      text: AppStrings.onlyPunch,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
