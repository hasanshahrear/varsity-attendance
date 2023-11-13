import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.navigating();
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 5,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/logo.svg',
                    width: 210,
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SpinKitRipple(
                    color: Colors.green.shade900,
                    size: 50,
                    duration: const Duration(milliseconds: 1500),
                    borderWidth: 3,
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Center(
              child: Text("DEVELOPED BY FREELANCER IT", style: TextStyle(
                fontSize: 12.0,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
                wordSpacing: 7,
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
