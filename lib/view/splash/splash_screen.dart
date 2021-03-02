import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shoppiya_admin/controller/splash_controller.dart';
import 'package:shoppiya_admin/utils/style.dart';

class SplashScreen extends StatelessWidget {
  var splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
            ),

            SizedBox(height: Get.height * .04),

            Text(
              "Welcome to Soppiya!",
              style: TextStyle(
                  color: Style.logoTextColor, fontWeight: FontWeight.w600, fontFamily: "Montserrat", fontSize: 24),
            ),
            Text(
              "Make your eCommerce easy and fun!",
              style: TextStyle(
                  color: Style.deSelectedTextColor, fontFamily: "Montserrat", fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
