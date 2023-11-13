import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:employee_attendance_getx/app/modules/home/controllers/connectivity_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final ConnectivityController connectivityController =
      Get.put(ConnectivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final connectionStatus = connectivityController.connectionStatus.value;
        if (connectionStatus == ConnectivityResult.none) {
          return const Center(
            child: Text('No Internet Connection ', style: TextStyle(fontSize: 22.0, color: Colors.red),),
          );
        } else {
          return Container(
            height: double.infinity,
            color: const Color.fromRGBO(34, 184, 239, 1),
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      color: Colors.black12,
                      spreadRadius: 0,
                      blurRadius: 5,
                    )
                  ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: Container(
                        color: Colors.white.withOpacity(0.7),
                        padding: const EdgeInsets.symmetric(vertical: 25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                              child: Column(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    'assets/svgs/logo.svg',
                                    width: 100,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  const SizedBox(height: 25.0),
                                  TextFormField(
                                    controller: controller.phoneController,
                                    obscureText: false,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Phone Number',
                                    ),
                                  ),
                                  const SizedBox(height: 25.0),
                                  Obx(() {
                                    return TextFormField(
                                      controller: controller.passwordController,
                                      obscureText: controller.obscureText.value,
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        labelText: 'Enter Password',
                                        suffixIcon: IconButton(
                                          icon: Icon(controller.obscureText.value
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          onPressed: () {
                                            controller.showPassword();
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                                  const SizedBox(height: 15.0),
                                  // Row(
                                  //   children: [
                                  //     Obx(() {
                                  //       return Checkbox(
                                  //         value: controller.rememberMeFlag.value,
                                  //         onChanged: (value) {
                                  //           controller.checkMark();
                                  //         },
                                  //         materialTapTargetSize:
                                  //         MaterialTapTargetSize.shrinkWrap,
                                  //         shape: RoundedRectangleBorder(
                                  //           borderRadius:
                                  //           BorderRadius.circular(5.0),
                                  //           side: BorderSide(
                                  //             color: Colors.grey.shade300,
                                  //             width: 1,
                                  //           ),
                                  //         ),
                                  //       );
                                  //     }),
                                  //     const Text(
                                  //       "Remember me",
                                  //       style: TextStyle(
                                  //         color: Colors.black87,
                                  //         fontWeight: FontWeight.w500,
                                  //         letterSpacing: 1,
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                  // const SizedBox(height: 10.0),
                                  Obx(() {
                                    return InkWell(
                                      onTap: () async {
                                        await controller.login();
                                      },
                                      child: controller.loading.value == true
                                          ? const CircularProgressIndicator(
                                        color: Colors.blue,
                                      )
                                          : Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            color: Colors.blue,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.25),
                                                spreadRadius: 0,
                                                blurRadius: 10,
                                                offset: const Offset(0, 2),
                                              ),
                                            ]),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14.0),
                                        width: double.infinity,
                                        // height: (50.0),
                                        child: const Text(
                                          "SIGN IN",
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }),
                                  const SizedBox(height: 30.0),
                                  // const Text(
                                  //   "Forgot your password?",
                                  //   style: TextStyle(
                                  //     fontSize: 12.0,
                                  //     color: Colors.black38,
                                  //     fontWeight: FontWeight.w400,
                                  //     letterSpacing: 1,
                                  //   ),
                                  //   textAlign: TextAlign.center,
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
