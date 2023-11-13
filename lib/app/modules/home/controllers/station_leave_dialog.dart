import 'dart:convert';
import 'package:employee_attendance_getx/app/data/models/leave_apply_model.dart';
import 'package:employee_attendance_getx/app/data/models/login_model.dart';
import 'package:employee_attendance_getx/app/data/preference.dart';
import 'package:employee_attendance_getx/app/data/services/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextInputDialogController extends GetxController {
  TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  RxString token = "".obs;
  late LoginModel userInfo;
  late LeaveApplyModel? leaveApply;

  void getUserInfo() async {
    userInfo = Preference.getUserDetails();
    token.value = userInfo.token!;
  }

  DateTime currentDateTime = DateTime.now();

  void saveText() {
    String enteredText = textController.text;
    // leave apply
    Future<void> stationLeave() async {
      try {
        var response = await HomeService.stationLeave(token: token.value,
          reason: enteredText,
          startTime: currentDateTime.toString());
        leaveApply = leaveApplyModelFromJson(jsonEncode(response));
        if (leaveApply?.success == true) {
          Get.snackbar(
            'Success',
            leaveApply?.message as String,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            icon: const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
          );
        } else {
          Get.snackbar(
            'Failed',
            'Something Went Wrong',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            icon: const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
          );
        }
      } catch (e) {
        Get.snackbar(
          'Failed',
          'Something Went Wrong',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
        );
      }
    }
    stationLeave();
    textController.text = "";
    print(enteredText);
    Get.back();
  }

  void stationBack() async {
    try {
      var response = await HomeService.stationBack(
        token: token.value, endTime: currentDateTime.toString(),);
      leaveApply = leaveApplyModelFromJson(jsonEncode(response));
      if (leaveApply?.success == true) {
        Get.snackbar(
          'Success',
          leaveApply?.message as String,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
        );
      } else {
        Get.snackbar(
          'Failed',
          leaveApply?.message as String,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        'Something Went Wrong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
      );
    }
  }
}