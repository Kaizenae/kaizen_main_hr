// ignore_for_file: use_build_context_synchronously

import 'package:Attendace/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../core/utils/assets_manager.dart';
import '../core/utils/color_manager.dart';
import '../core/utils/strings_manager.dart';
import '../core/widgets/svg_pic/svg_pic.dart';
import 'edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'home/presentation/screens/home_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final _screens = [
    const HomeScreen(),

    // const AttendanceScreen(),
    const ProfileScreen(),

    // const CategoryScreen(),
    //
    // const ProfileScreen(),
  ];
  final List<String> _icons = [
    IconsAssets.homeIcon,
    // IconsAssets.attendIcon,
    IconsAssets.personIcon,
  ];

  final List<String> _labels = [
    AppStrings.home,
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
            // if (AppConstants.admin ? index == 2 : index == 1) {
            //   BlocProvider.of<AttendanceCubit>(context).getAttendanceFun();
            // } else if (AppConstants.admin ? index == 3 : index == 2) {
            //   ProfileCubit.get(context).getEmployeeFun();
            // }
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
