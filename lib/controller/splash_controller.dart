import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppiya_admin/view/welcom/welcome_screen.dart';

import '../main.dart';


class SplashController extends GetxController {
  @override
  void onInit() {
    SharedPreferences.getInstance().then((pr) {
      prefs = pr;
    });
    Timer(Duration(seconds: 3), () => Get.off(WelcomeScreen()));
    super.onInit();
  }
}