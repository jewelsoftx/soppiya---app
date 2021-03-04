import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConstant {
  //......  share preference key
  static final String tokenS = "TOKEN";
  static final String statusKey = "status";
  static final String messageKey = "message";
  static final String errorKey = "Error";
  static final String successKey = "Success";
  static final String tokenKey = "token";
  static final String emailKey = "email";
  static final String passwordKey = "password";
  static final String loginDataKey = "loginData";
  static final String referralKey = "referral";

}


void errorSnackbar(
  String msg,
) {
  return Get.snackbar('error'.tr, "$msg",
      snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red[400], colorText: Colors.white);
}

void successSnackbar(String msg) {
  return Get.snackbar('success'.tr, "$msg",
      snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green[400], colorText: Colors.white);
}
