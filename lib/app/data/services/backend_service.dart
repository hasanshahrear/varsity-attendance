import 'dart:async';
import 'dart:ui';
import 'package:employee_attendance_getx/app/modules/home/controllers/connectivity_controller.dart';
import 'package:employee_attendance_getx/app/modules/home/controllers/sensors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:get/get.dart';

final SensorController _sensorController = Get.put(SensorController());
final ConnectivityController _connectivityController = Get.put(ConnectivityController());

Future<void> initializeService() async {
  var service = FlutterBackgroundService();
  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onBackground: backgroundService,
    ),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> backgroundService(ServiceInstance serviceInstance) async{
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(minutes: 30), (timer) async {
    _sensorController.onInit();
    _connectivityController.onInit();
    /// you can see this log in logcat
    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    service.invoke("update");
  });
}
