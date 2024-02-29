// ignore_for_file: use_build_context_synchronously

import 'package:Attendace/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:Attendace/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:Attendace/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import '../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../core/utils/assets_manager.dart';
import '../core/utils/color_manager.dart';
import '../core/utils/strings_manager.dart';
import '../core/widgets/svg_pic/svg_pic.dart';
import 'all_employee/presentation/cubit/all_employees_cubit.dart';
import 'home/presentation/screens/home_screen.dart';

class MainPageAdmin extends StatefulWidget {
  const MainPageAdmin({super.key});

  @override
  MainPageAdminState createState() => MainPageAdminState();
}

class MainPageAdminState extends State<MainPageAdmin> {
  final _screens = [
    const HomeScreen(),
    // const AllEmployeesScreen(),
    // const AttendanceScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];
  final List<String> _icons = [
    IconsAssets.homeIcon,
    // IconsAssets.searchIcon,
    IconsAssets.notificationIcon,
    IconsAssets.personIcon,
  ];

  final List<String> _labels = [
    AppStrings.home,
    // AppStrings.employees,
    AppStrings.notifications,
    AppStrings.profile,
  ];

  int _selectedIndex = 0;

  String subtitle = '';
  String content = '';
  String data = '';
  String debugLabelString = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      // appBarCustom: AppBarCustom(
      //     isNull: false,
      //     // text: _selectedIndex == 0
      //     //     ? AppStrings.home
      //     //     : _selectedIndex == 1
      //     //         ? AppStrings.attendance
      //     //         : AppStrings.profile
      // ),
      body: SafeArea(
        child: Stack(
          children: _screens
              .asMap()
              .map((index, screen) {
                return MapEntry(
                  index,
                  Offstage(
                    offstage: _selectedIndex != index,
                    child: screen,
                  ),
                );
              })
              .values
              .toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            // if (index == 2) {
            //   BlocProvider.of<AttendanceCubit>(context).getAttendanceFun();
            // } else
            if (index == 2) {
              ProfileCubit.get(context).getEmployeeFun();
            } else if (index == 1) {
              AllEmployeesCubit.get(context).getEmployeesFun();
            }
            setState(() {
              _selectedIndex = index;
            });
          },
          iconSize: 24,
          items: List.generate(
              _screens.length,
              (index) => bottom(
                    icon: _icons[index],
                    label: _labels[index],
                  ))),
    );
  }

  BottomNavigationBarItem bottom(
      {required String icon, required String label}) {
    return BottomNavigationBarItem(
      icon: SvgPictureCustom(
        assetsName: icon,
        color: ColorManager.grey1,
      ),
      label: label,
      activeIcon: SvgPictureCustom(assetsName: icon),
    );
  }
}
