import 'package:employee_attendance_getx/app/data/preference.dart';
import 'package:employee_attendance_getx/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  void navigating() async {
    if (Preference.getLoggedInFlag() && Preference.getUserLocation()) {
      Future.delayed(
        const Duration(seconds: 7),
        () => Get.offAllNamed(Routes.HOME),
      );
    } else {
      Future.delayed(
        const Duration(seconds: 7),
        () => Get.offAllNamed(Routes.LOGIN),
      );
    }
  }
}
