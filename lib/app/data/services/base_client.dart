import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:employee_attendance_getx/app/constrants/strings.dart';

class BaseClient {
  static Future<dynamic> getData({
    String? token,
    required String api,
    dynamic parameter,
  }) async {
    String url = '${ConstantStrings.kAppBaseUrl}/$api';

    try {
      var response = await Dio().get(
        url,
        options: token != null
            ? Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              )
            : null,
        queryParameters: parameter,
      );
      print('GET Method: ${response.statusCode}');
      print(url);
      log("GET Response:  ${jsonEncode(response.data)}");
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  static Future<dynamic> postData({
    required String api,
    String? token,
    dynamic body,
  }) async {
    String url = '${ConstantStrings.kAppBaseUrl}/$api';

    if (body != null) log("Post Body: $body");
    try {
      var response = await Dio().post(
        url,
        options: token != null
            ? Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              )
            : null,
        data: body,
      );
      print('POST Method: ${response.statusCode}');
      print(url);
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}
