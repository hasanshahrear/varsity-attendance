import 'package:employee_attendance_getx/app/constrants/strings.dart';
import 'package:employee_attendance_getx/app/data/services/base_client.dart';

class AuthService {
  static Future<dynamic> login({
    required String phone,
    required String pass,
  }) async {
    return await BaseClient.postData(
      api: ConstantStrings.kSignIn,
      body: {
        "phone": phone,
        "password": pass,
      },
    );
  }
}
