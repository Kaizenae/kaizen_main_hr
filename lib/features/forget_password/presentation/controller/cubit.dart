import 'dart:math';
import 'dart:developer' as de;

import 'package:Attendace/core/api/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit() : super(ForgetPasswordInitState());
  int? otpNumber;
  String message = "";
  void createRandomOtp() {
    Random random = Random();

    // Generate a random 4-digit number
    otpNumber = random.nextInt(999999) + 100000;
    message = "Your OTP is $otpNumber It will be invalid after 1 min";
    emit(CreateOtpState());
  }

  void sendOtp({required String phoneNumber}) {
    createRandomOtp();
    Dio().post(
      EndPoints.otpPath,
      queryParameters: {
        "action": "send-sms",
        "api_key":
            "SWRlYWNyYXRlIFA6JDJ5JDEwJFdXWlYzOTNUYjQ5TmVvU0NmRURmSS53MkNTakYwVWdMNXhQUVV6dlZlVEpEelF4MHp0aWlh",
        "to": "971$phoneNumber",
        "from": "ORANGEWHEEL",
        "sms": message,
        "response": "json",
      },
    ).then((value) {
      emit(SendOtpSuccessState());
    }).catchError((error) {
      emit(
          SendOtpErrorState(message: "Some thing went wrong, Try again later"));
    });
  }

  late int userId;

  void getUserId({required String phoneNumber}) {
    emit(GetUserIdLoadingState());
    Dio().post(
      EndPoints.getUserIDPath,
      data: {
        "jsonrpc": "2.0",
        "params": {
          "phone": "0$phoneNumber",
        }
      },
    ).then((value) {
      userId = value.data["result"]["user_id"] as int;
      emit(GetUserIdSuccessState(
          message: value.data["result"]["message"], userID: userId));
    }).catchError((error) {
      de.log(error.toString());
      emit(GetUserIdErrorState(message: "Not Registered Number!"));
    });
  }

  void changePassword(
      {required String phoneNunber,
      required String userId,
      required String newPassword}) {
    emit(ChangePasswordLoadingState());
    Dio().post(EndPoints.forgetPasswordPath, data: {
      "jsonrpc": "2.0",
      "params": {
        "user_id": userId,
        "phone": "0$phoneNunber",
        "new_password": newPassword,
      }
    }).then((value) {
      emit(
          ChangePasswordSuccessState(message: value.data["result"]["message"]));
    }).catchError((error) {
      emit(ChangePasswordErrorState(
          message: "Some thing went wrong, Try again later"));
    });
  }
}
