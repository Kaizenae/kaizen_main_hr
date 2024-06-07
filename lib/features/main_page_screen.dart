// ignore_for_file: use_build_context_synchronously

import 'package:Attendace/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import '../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../core/utils/assets_manager.dart';
import '../core/utils/color_manager.dart';
import '../core/utils/strings_manager.dart';
import '../core/widgets/svg_pic/svg_pic.dart';
import 'home/presentation/screens/home_screen.dart';
import 'profile/presentation/cubit/profile_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final _screens = [
    const HomeScreen(),
    const ProfileScreen(),
  ];
  final List<String> _icons = [
    IconsAssets.homeIcon,
    IconsAssets.personIcon,
  ];

  final List<String> _labels = [
    AppStrings.home,
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
      body: SafeArea(
        child: Stack(
          children: _screens
              .asMap()
              .map(
                (index, screen) {
                  return MapEntry(
                    index,
                    Offstage(
                      offstage: _selectedIndex != index,
                      child: screen,
                    ),
                  );
                },
              )
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
          if (index == 1) {
            ProfileCubit.get(context).getEmployeeFun();
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
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.primary,
        isExtended: true,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: ColorManager.white,
        ),
      ),
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
