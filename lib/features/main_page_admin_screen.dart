// ignore_for_file: use_build_context_synchronously

import 'package:Attendace/features/all_employee/presentation/screens/all_employees_screen.dart';
import 'package:Attendace/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:Attendace/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../core/utils/assets_manager.dart';
import '../core/utils/color_manager.dart';
import '../core/utils/strings_manager.dart';
import '../core/widgets/svg_pic/svg_pic.dart';
import 'all_employee/presentation/cubit/all_employees_cubit.dart';
import 'edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'home/presentation/screens/home_screen.dart';

class MainPageAdmin extends StatefulWidget {
  const MainPageAdmin({super.key});

  @override
  MainPageAdminState createState() => MainPageAdminState();
}

class MainPageAdminState extends State<MainPageAdmin> {
  final _screens = [
    const HomeScreen(),
    const AllEmployeesScreen(),
    // const AttendanceScreen(),
    const ProfileScreen(),
  ];
  final List<String> _icons = [
    IconsAssets.homeIcon,
    IconsAssets.searchIcon,
    // IconsAssets.attendIcon,
    IconsAssets.personIcon,
  ];

  final List<String> _labels = [
    AppStrings.home,
    AppStrings.employees,
    // AppStrings.attendance,
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
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;

    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    await addNoId();
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      setState(() {
        debugLabelString =
            "Opened notification:${result.notification.title} \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      /// Display Notification, send null to not display
      event.complete(event.notification);

      setState(() {
        debugLabelString =
            "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {});

    OneSignal.shared
        .setPermissionObserver((OSPermissionStateChanges changes) {});

// NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared.setAppId("5ba556fc-28d8-4500-8d4a-f151fea9e04d");
  }

  Future<void> addNoId() async {
    var deviceState = await OneSignal.shared.getDeviceState();

    if (deviceState == null || deviceState.userId == null) return;

    var playerId = deviceState.userId!;
    BlocProvider.of<EditProfileCubit>(context).noId = playerId;

    BlocProvider.of<EditProfileCubit>(context).editNoIdFun();
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
