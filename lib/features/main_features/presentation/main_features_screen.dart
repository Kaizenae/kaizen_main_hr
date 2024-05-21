import 'package:Attendace/core/utils/color_manager.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/constants_manager.dart';
import '../../../core/utils/font_manager.dart';
import '../../../core/utils/routes_manager.dart';
import '../../../core/widgets/component.dart';

class MainFeaturesScreen extends StatelessWidget {
  const MainFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: ColorManager.primary,
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Image(image: AssetImage(ImageAssets.logoName)),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    color: ColorManager.scaffoldColor),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          navigator(
                              context,
                              AppConstants.admin
                                  ? Routes.mainRouteAdmin
                                  : Routes.mainRoute);
                        },
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: ColorManager.lightGrey2,
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        ImageAssets.back9,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Image(
                                      image: AssetImage(
                                        ImageAssets.hrImg,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 100,
                                  color: ColorManager.scaffoldColor,
                                  child: const Center(
                                    child: Text(
                                      AppStrings.hr,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: FontConstants.fontFamily,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.lightGrey2,
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      ImageAssets.back7,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Image(
                                    image: AssetImage(
                                      ImageAssets.projectsImg,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 100,
                                color: ColorManager.scaffoldColor,
                                child: const Center(
                                  child: Text(
                                    AppStrings.projects,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: FontConstants.fontFamily,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.expensesRoute,
                          );
                        },
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: ColorManager.lightGrey2,
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        ImageAssets.back8,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Image(
                                      image: AssetImage(
                                        ImageAssets.expensesImg,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 100,
                                  color: ColorManager.scaffoldColor,
                                  child: const Center(
                                    child: Text(
                                      AppStrings.expenses,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: FontConstants.fontFamily,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
