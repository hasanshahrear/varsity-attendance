import 'dart:convert';
import 'package:employee_attendance_getx/app/data/models/check_in_model.dart';
import 'package:employee_attendance_getx/app/data/models/check_out_model.dart';
import 'package:employee_attendance_getx/app/data/models/get_location_model.dart';
import 'package:employee_attendance_getx/app/data/models/leave_apply_model.dart';
import 'package:employee_attendance_getx/app/data/models/login_model.dart';
import 'package:employee_attendance_getx/app/data/models/update_location_model.dart';
import 'package:employee_attendance_getx/app/data/preference.dart';
import 'package:employee_attendance_getx/app/data/services/home.dart';
import 'package:employee_attendance_getx/app/data/services/location.dart';
import 'package:employee_attendance_getx/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final Rx<ConnectivityResult> connectionStatus = Rx<ConnectivityResult>(ConnectivityResult.none);

  @override
  @override
  void onInit() {
    super.onInit();
    getUserInfo();
    getLocationData();
    getOfficeLocation();
    _initConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void onReady() {
    super.onReady();
    getDistance();
  }


  Future<void> _initConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    connectionStatus.value = result;
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    connectionStatus.value = result;
  }

  // variables
  RxDouble longitude = 0.0.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble offLongitude = 0.0.obs;
  RxDouble offLatitude = 0.0.obs;
  RxBool isSetLocation = false.obs;
  RxString token = "".obs;
  RxDouble distance = 0.0.obs;

  // user info
  RxString firstName = "".obs;
  RxString lastName = "".obs;
  RxString designation = "".obs;
  RxString phone = "".obs;
  RxString officeAddress = "".obs;

  // models
  late LoginModel userInfo;
  late LocationModel? officeLocation;
  late CheckInModel? checkInRes;
  late CheckOutModel? checkOutRes;
  late LeaveApplyModel? leaveApply;
  late UpdateLocationModel? updateLocation;

  // location isSet or not
  void getUserInfo() async {
    userInfo = Preference.getUserDetails();
    var loc = Preference.getUserLocation();
    isSetLocation.value = loc;
    token.value = userInfo.token!;
    firstName.value = userInfo.user?.firstName! as String;
    lastName.value = userInfo.user?.lastName! as String;
    designation.value = userInfo.user?.designation! as String;
    phone.value = userInfo.user?.phone! as String;
    officeAddress.value = userInfo.user?.officeAddress! as String;
  }

  // phone current location
  Future<void> getLocationData() async {
    try {
      Location location = Location();
      await location.getCurrentLocation();
      longitude.value = location.longitude;
      latitude.value = location.latitude;
      // Get.snackbar(
      //   'Success',
      //   'Location Updated',
      //   backgroundColor: const Color.fromARGB(1000, 1, 166, 126),
      //   colorText: Colors.white,
      //   icon: const Icon(
      //     Icons.check_circle,
      //     color: Colors.white,
      //   ),
      // );
    } catch (e) {
      Get.snackbar(
        'Failed',
        'Enable Location Services',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
      );
    }
  }

  // office location from db
  Future<void> getOfficeLocation() async {
    try {
      var response = await HomeService.getOfficeLocation(token: token.value);
      officeLocation = locationModelFromJson(jsonEncode(response));
      offLongitude.value = officeLocation?.data?.longitude as double;
      offLatitude.value = officeLocation?.data?.latitude as double;
      // Get.snackbar(
      //   'Success',
      //   'Office Location Updated',
      //   backgroundColor: const Color.fromARGB(1000, 245, 178, 5),
      //   colorText: Colors.white,
      //   icon: const Icon(
      //     Icons.check_circle,
      //     color: Colors.white,
      //   ),
      // );
      getDistance();
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

  // update office location
  Future<void> updateOfficeLocation() async {
    try {
      var response = await HomeService.updateOfficeLocation(
        token: token.value,
        longitude: longitude.value.toString(),
        latitude: latitude.value.toString(),
      );
      updateLocation = updateLocationModelFromJson(jsonEncode(response));
      isSetLocation.value = true;
      if (updateLocation?.success == true) {
        Preference.setUserLocation(true);
        // Get.snackbar(
        //   'Success',
        //   updateLocation?.message as String,
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        //   icon: const Icon(
        //     Icons.check_circle,
        //     color: Colors.white,
        //   ),
        // );
      } else {
        Get.snackbar(
          'Failed',
          updateLocation?.message as String,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
        );
      }

    } catch (e) {
      print(e);
    }
  }
  // calculate distance between office and phone location
  void getDistance() {
    if (isSetLocation.value == true) {
      distance.value = Geolocator.distanceBetween(
        offLatitude.value,
        offLongitude.value,
        latitude.value,
        longitude.value,
      );
    }
  }


  // check in
  Future<void> checkIn() async {
    try {
      getDistance();
      var response = await HomeService.checkIn(
          token: token.value, distanceInMeters: distance.toDouble());
      checkInRes = checkInModelFromJson(jsonEncode(response));
      if (checkInRes?.success == true) {
        Preference.setCheckInFlag(true);
        Get.snackbar(
          'Success',
          checkInRes?.message as String,
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
          checkInRes?.message as String,
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

  // check out
  Future<void> checkOut() async {
    try {
      getDistance();
      var response = await HomeService.checkOut(
        token: token.value,
        distanceInMeters: distance.toDouble(),
      );
      checkOutRes = checkOutModelFromJson(jsonEncode(response));
      if (checkOutRes?.success == true) {
        Preference.setCheckInFlag(false);
        Get.snackbar(
          'Success',
          checkOutRes?.message as String,
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

  // leave apply
  Future<void> leave() async {
    try {
      var response = await HomeService.leaveApply(token: token.value);
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

  // logout
  void logout() {
    Preference.clearAll();
    Get.offAllNamed(Routes.LOGIN);
  }
}
