// ignore_for_file: unused_catch_clause, unrelated_type_equality_checks

import 'dart:io';
import 'package:Attendace/core/utils/assets_manager.dart';
import 'package:Attendace/core/utils/routes_manager.dart';
import 'package:Attendace/core/widgets/component.dart';
import 'package:Attendace/core/widgets/svg_pic/svg_pic.dart';
import 'package:Attendace/core/widgets/text_custom/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'core/api/end_points.dart';
import 'core/utils/color_manager.dart';
import 'core/utils/constants_manager.dart';
import 'core/utils/font_manager.dart';
import 'core/utils/strings_manager.dart';
import 'core/utils/values_manager.dart';
import 'core/widgets/scaffold_custom/scaffold_custom.dart';

class LocalAuthScreen extends StatefulWidget {
  const LocalAuthScreen({super.key});

  @override
  State<LocalAuthScreen> createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    fingerOrFaceAuth();
  }

  String msg = "You are not authorized.";
  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
// appBarCustom: AppBarCustom(
//   isNull: false,
// ),
        body: Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: TextCustom(
            color: ColorManager.primary,
            text: 'Please Authenticate to Continue ...',
            fontSize: FontSize.s26,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          )),
          const SizedBox(
            height: AppSize.s40,
          ),
          InkWell(
              onTap: () async {
                await fingerOrFaceAuth();
              },
              child: const SvgPictureCustom(
                  assetsName: IconsAssets.fingerprintIcon,
                  color: ColorManager.skyColor,
                  height: AppSize.s100 * 1.8)),
        ],
      ),
    ));
  }

  Future<void> fingerOrFaceAuth() async {
    try {
      bool hasbiometrics =
          await auth.canCheckBiometrics; //check if there is authencations,
      bool pass = false;
      if (hasbiometrics) {
        List<BiometricType> availableBiometrics =
            await auth.getAvailableBiometrics();
        if (Platform.isIOS) {
          if (availableBiometrics.contains(BiometricType.face)) {
            bool pass = await auth.authenticate(
              localizedReason: 'Authenticate with fingerprint',
              options: const AuthenticationOptions(
                stickyAuth: false,
                biometricOnly: true,
              ),
            );

            if (pass) {
              msg = "You are Autenciated.";
              setState(() {});
              Future.delayed(
                const Duration(milliseconds: 300),
                () => navigatorAndRemove(
                  context,
                  EndPoints.baseUrl.isEmpty
                      ? Routes.baseUrlRoute
                      : AppConstants.token == AppStrings.empty ||
                              AppConstants.token == 0
                          ? Routes.loginRoute
                          : AppConstants.admin
                              ? Routes.mainRouteAdmin
                              : Routes.mainRoute,
                ),
              );
            }
          } else {
            if (availableBiometrics.contains(BiometricType.fingerprint)) {
              pass = await auth.authenticate(
                localizedReason: 'Authenticate with fingerprint/face',
                options: const AuthenticationOptions(
                  stickyAuth: false,
                  biometricOnly: true,
                ),
              );

              if (pass) {
                msg = "You are Authenicated.";
                setState(() {});
                Future.delayed(
                  const Duration(milliseconds: 300),
                  () => navigatorAndRemove(
                    context,
                    EndPoints.baseUrl.isEmpty
                        ? Routes.baseUrlRoute
                        : AppConstants.token == AppStrings.empty ||
                                AppConstants.token == 0
                            ? Routes.loginRoute
                            : AppConstants.admin
                                ? Routes.mainRouteAdmin
                                : Routes.mainRoute,
                  ),
                );
              }
            }
          }
        } else {
          if (availableBiometrics.contains(BiometricType.strong)) {
            bool pass = await auth.authenticate(
              localizedReason: 'Authenticate with fingerprint',
              options: const AuthenticationOptions(
                stickyAuth: false,
                biometricOnly: true,
              ),
            );

            if (pass) {
              msg = "You are Autenciated.";
              setState(() {});
              Future.delayed(
                const Duration(milliseconds: 300),
                () => navigatorAndRemove(
                  context,
                  EndPoints.baseUrl.isEmpty
                      ? Routes.baseUrlRoute
                      : AppConstants.token == AppStrings.empty ||
                              AppConstants.token == 0
                          ? Routes.loginRoute
                          : AppConstants.admin
                              ? Routes.mainRouteAdmin
                              : Routes.mainRoute,
                ),
              );
            }
          } else {
            if (availableBiometrics.contains(BiometricType.weak)) {
              pass = await auth.authenticate(
                localizedReason: 'Authenticate with fingerprint/face',
                options: const AuthenticationOptions(
                  stickyAuth: false,
                  biometricOnly: true,
                ),
              );

              if (pass) {
                msg = "You are Authenicated.";
                setState(() {});
                Future.delayed(
                  const Duration(milliseconds: 300),
                  () => navigatorAndRemove(
                    context,
                    EndPoints.baseUrl.isEmpty
                        ? Routes.baseUrlRoute
                        : AppConstants.token == AppStrings.empty ||
                                AppConstants.token == 0
                            ? Routes.loginRoute
                            : AppConstants.admin
                                ? Routes.mainRouteAdmin
                                : Routes.mainRoute,
                  ),
                );
              }
            }
          }
        }
      }
    } on PlatformException catch (e) {
      msg = "Error while opening fingerprint/face scanner";
    }
  }
}
