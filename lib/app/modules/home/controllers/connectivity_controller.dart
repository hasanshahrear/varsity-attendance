import 'package:employee_attendance_getx/app/data/models/login_model.dart';
import 'package:employee_attendance_getx/app/data/preference.dart';
import 'package:employee_attendance_getx/app/data/services/home.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final Rx<ConnectivityResult> connectionStatus =
      Rx<ConnectivityResult>(ConnectivityResult.none);
  RxString token = "".obs;

  // models
  late LoginModel userInfo;

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
    _initConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _initConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    connectionStatus.value = result;
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    connectionStatus.value = result;
    // Call getOutOfConnection method when status changes
    getOutOfConnection(result);
  }

  // location isSet or not
  void getUserInfo() async {
    userInfo = Preference.getUserDetails();
    token.value = userInfo.token!;
  }

  void getOutOfConnection(ConnectivityResult status) async {
    var isOffTime = Preference.getDataOffTime();
    var isCheckedIn = Preference.getCheckInFlag();
    var isOnceSubmit = Preference.getOnceSubmit();

    if (status == ConnectivityResult.none && isCheckedIn == true) {
      var offTime = DateTime.now().toString();
      Preference.setDataOffTime(offTime);
      Preference.setOnceSubmit(true);
    }

    if (status != ConnectivityResult.none &&
        isOffTime != '' &&
        isOnceSubmit == true) {
      Preference.setOnceSubmit(false);
      var onTime = DateTime.now().toString();
      try {
        await HomeService.connectionStatus(
            token: token.value, offTime: isOffTime, onTime: onTime);
      } catch (e) {}
    }
  }
}
