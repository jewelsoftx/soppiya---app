import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppiya_admin/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {

  var splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png",height: 200,),
      ),
    );
  }
}
