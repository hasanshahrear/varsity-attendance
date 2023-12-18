import 'dart:convert';
import 'package:employee_attendance_getx/app/data/models/login_model.dart';
import 'package:employee_attendance_getx/app/data/preference.dart';
import 'package:employee_attendance_getx/app/data/services/auth.dart';
import 'package:employee_attendance_getx/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool loading = false.obs;
  RxBool obscureText = true.obs;
  late TextEditingController phoneController, passwordController;
  LoginModel? user;

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    // if (Preference.getRememberMeFlag()) {
      phoneController.text = Preference.getLoginPhone();
      passwordController.text = Preference.getLoginPass();
    // }
  }

  @override
  void onClose() {
    super.onClose();
    phoneController.dispose();
    passwordController.dispose();
  }

  Future<void> login() async {
    loading.value = true;
    try {
      var response = await AuthService.login(
        phone: phoneController.text,
        pass: passwordController.text,
      );

      user = loginModelFromJson(
        jsonEncode(response),
      );
      if (user?.token != null) {
        loading.value = false;
        Preference.setUserDetails(user!);
        Get.snackbar(
          'Success',
          'Login Successful',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
        );

        // if (rememberMeFlag.value) {
          Preference.setLoginPhone(phoneController.text);
          Preference.setLoginPass(passwordController.text);
          // Preference.setRememberMeFlag(true);
          Preference.setLoggedInFlag(true);
          Preference.setUserLocation(user?.location as bool);
        // }
        Get.offAllNamed(Routes.HOME);
      } else {
        loading.value = false;
        Get.snackbar(
          'Failed',
          "Invalid User!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
        );
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar(
        'Failed',
        "Invalid User!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
      );
    }
  }



  void showPassword() {
    obscureText.toggle();
  }
}
