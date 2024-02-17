// ignore_for_file: unused_catch_clause

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  final LocalAuthentication auth = LocalAuthentication();
  bool? canCheckBiometrics;
  List<BiometricType>? availableBiometric;
  String authorized = 'Not Authorized';
  bool isAuthenticating = false;

  Future<void> checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
    }

    canCheckBiometrics = canCheckBiometrics;
  }

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
    }

    availableBiometric = availableBiometrics;
  }

  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      isAuthenticating = true;
      authorized = 'Authenticating';
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      isAuthenticating = false;
    } on PlatformException catch (e) {
      isAuthenticating = false;
      authorized = 'Error - ${e.message}';
      return;
    }

    authorized = authenticated ? 'Authorized' : 'Not Authorized';
  }

  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      isAuthenticating = true;
      authorized = 'Authenticating';
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      isAuthenticating = false;
      authorized = 'Authenticating';
    } on PlatformException catch (e) {
      isAuthenticating = false;
      authorized = 'Error - ${e.message}';
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    authorized = message;
  }

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
    isAuthenticating = false;
  }
}
