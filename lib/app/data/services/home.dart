import 'package:employee_attendance_getx/app/constrants/strings.dart';
import 'package:employee_attendance_getx/app/data/services/base_client.dart';

class HomeService {
  static Future<dynamic> getOfficeLocation({
    required String token,
  }) async {
    return await BaseClient.getData(
        api: ConstantStrings.kGetOfficeLocation, token: token);
  }

  static Future<dynamic> updateOfficeLocation({
    required String token,
    required String longitude,
    required String latitude,
  }) async {
    return await BaseClient.postData(
      api: ConstantStrings.kUpdateLocation,
      token: token,
      body: {
        "longitude": longitude,
        "latitude": latitude,
      },
    );
  }

  static Future<dynamic> checkIn(
      {required String token, required double distanceInMeters}) async {
    return await BaseClient.postData(
      api: ConstantStrings.kCheckIn,
      token: token,
      body: {
        "distance": distanceInMeters.toInt().toString(),
      },
    );
  }

  static Future<dynamic> checkOut(
      {required String token, required double distanceInMeters}) async {
    return await BaseClient.postData(
      api: ConstantStrings.kCheckOut,
      token: token,
      body: {
        "distance": distanceInMeters.toInt().toString(),
      },
    );
  }

  static Future<dynamic> leaveApply({required String token}) async {
    return await BaseClient.postData(
      api: ConstantStrings.kLeave,
      token: token,
    );
  }

  static Future<dynamic> inactive(
      {required String token, required String time}) async {
    return await BaseClient.postData(
      api: ConstantStrings.kInactive,
      token: token,
      body: {
        "time": time,
      },
    );
  }

  static Future<dynamic> stationLeave(
      {required String token, required String reason, String? startTime, String? endTime }) async {
    return await BaseClient.postData(
      api: ConstantStrings.kStationLeave,
      token: token,
      body: {
        "reason": reason,
        "start_time": startTime,
      },
    );
  }
  static Future<dynamic> stationBack(
      {required String token,  String? endTime }) async {
    return await BaseClient.postData(
      api: ConstantStrings.kStationBack,
      token: token,
      body: {
        "end_time": endTime,
      },
    );
  }

  static Future<dynamic> connectionStatus(
      {required String token, required String offTime, required String onTime }) async {
    return await BaseClient.postData(
      api: ConstantStrings.kConnectionStatus,
      token: token,
      body: {
        "connection_off_time": offTime,
        "connection_on_time": onTime
      },
    );
  }

}
