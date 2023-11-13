import 'package:employee_attendance_getx/app/data/models/login_model.dart';
import 'package:get_storage/get_storage.dart';

class Preference {
  // initializing
  static final prefs = GetStorage();

  // keys
  static const loggedInFlag = 'loginFlag';
  static const rememberMeFlag = 'rememberMeFlag';
  static const loginPhone = 'loginPhone';
  static const loginPass = 'loginPass';
  static const userDetails = 'userDetails';
  static const useLocation = 'useLocation';
  static const dataOffTime = "dataOffTime";
  static const checkInFlag = 'checkInFlag';
  static const onceSubmit = 'onceSubmit';

  static bool getLoggedInFlag() => prefs.read(loggedInFlag) ?? true;
  static void setLoggedInFlag(bool value) => prefs.write(loggedInFlag, value);

  static bool getUserLocation() => prefs.read(useLocation) ?? false;
  static void setUserLocation(bool value) => prefs.write(useLocation, value);

  static bool getOnceSubmit() => prefs.read(onceSubmit) ?? false;
  static void setOnceSubmit(bool value) => prefs.write(onceSubmit, value);

  static bool getRememberMeFlag() => prefs.read(rememberMeFlag) ?? false;
  static void setRememberMeFlag(bool value) =>
      prefs.write(rememberMeFlag, value);

  static String getLoginPhone() => prefs.read(loginPhone) ?? '';
  static void setLoginPhone(String value) => prefs.write(loginPhone, value);

  static String getLoginPass() => prefs.read(loginPass) ?? '';
  static void setLoginPass(String value) => prefs.write(loginPass, value);

  static String getDataOffTime()=> prefs.read(dataOffTime) ?? '';
  static void setDataOffTime (String value) => prefs.write(dataOffTime, value);

  static bool getCheckInFlag() => prefs.read(checkInFlag) ?? false;
  static void setCheckInFlag(bool value) => prefs.write(checkInFlag, value);

  static LoginModel getUserDetails() {
    var result = prefs.read(userDetails);
    return loginModelFromJson(result);
  }
  static void setUserDetails(LoginModel value) {
    prefs.write(userDetails, loginModelToJson(value));
  }

  static void logout() => prefs.remove(loggedInFlag);

  static void clearAll() => prefs.erase();
}
