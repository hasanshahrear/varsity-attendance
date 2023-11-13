import 'dart:async';
import 'package:employee_attendance_getx/app/data/models/login_model.dart';
import 'package:employee_attendance_getx/app/data/preference.dart';
import 'package:employee_attendance_getx/app/data/services/home.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:get/get.dart';

class SensorController extends GetxController {
  bool apiCalled = false;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
    // Start listening to accelerometer events
    accelerometerEvents.listen((AccelerometerEvent event) {
      handleAccelerometerEvent(event);
    });
    // Start the timer when the controller is initialized
    startTimer();
  }

  @override
  void onClose() {
    // Cancel the timer when the controller is closed
    timer?.cancel();
    super.onClose();
  }

  // variables
  RxString token = "".obs;

  // models
  late LoginModel userInfo;

  // location isSet or not
  void getUserInfo() async {
    userInfo = Preference.getUserDetails();
    token.value = userInfo.token!;
  }

  void handleAccelerometerEvent(AccelerometerEvent event) {
    int currentX = event.x.abs().toInt();
    int currentY = event.y.abs().toInt();
    int currentZ = event.z.abs().toInt();

    // Check if there's any change in the accelerometer values
    if (currentX != 0 || currentY != 0 || currentZ != 9) {
      // Reset the timer if there's any change
      resetTimer();
      // print("test");
    }
  }

  void startTimer() {
    // Start a timer that fires after 1 hour (3600000 milliseconds)
    timer = Timer(const Duration(seconds: 10), () {
      if (!apiCalled) {
        // Call the API if it hasn't been called before
        callAPI();
        apiCalled = true;
        resetTimer();
      }
    });
  }

  void resetTimer() {
    // Reset the timer
    timer?.cancel();
    apiCalled = false;
    startTimer();
  }

  void callAPI() async {
    try {
      DateTime time = DateTime.now();
      await HomeService.inactive(token: token.value, time: time.toString());
    } catch (e) {}
  }
}
