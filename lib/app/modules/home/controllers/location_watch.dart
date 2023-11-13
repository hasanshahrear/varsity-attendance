import 'dart:async';
import 'package:employee_attendance_getx/app/modules/home/controllers/home_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationWatch extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _startListening();
  }

  HomeController homeController = Get.put(HomeController());
  // variables
  StreamSubscription<Position>? _positionStream;
  RxDouble distance = 0.0.obs;

  void _startListening() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    _positionStream = Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      distance.value = Geolocator.distanceBetween(
        homeController.offLatitude.value,
        homeController.offLongitude.value,
        position.latitude,
        position.longitude,
      );
    });
    print("dis");
    print(distance);
  }

  void _stopListening() {
    if (_positionStream != null) {
      _positionStream!.cancel();
      _positionStream = null;
    }
  }
}
