import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppiya_admin/main.dart';
import 'package:shoppiya_admin/model/login_model.dart';
import 'package:shoppiya_admin/networking/api_client.dart';
import 'package:shoppiya_admin/networking/network_utils.dart';
import 'package:shoppiya_admin/networking/url.dart';
import 'package:shoppiya_admin/utils/AppConstant.dart';
import 'package:shoppiya_admin/view/home.dart';

class AuthController extends GetxController{

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController referralTextController = TextEditingController();


  String emailErrorText = "";


  void doLoginApiCall(BuildContext context) {
    String email = emailTextController.text.toString();
    String pass = passwordTextController.text.toString();

    NetworkUtils.checkInternet().then(
          (intenet) {
        if (intenet != null && intenet) {
          if (email.isEmpty) {
            errorSnackbar('enter_email'.tr);
          } else if (!GetUtils.isEmail(email)) {
            errorSnackbar("valid_email".tr);
          } else if (pass.isEmpty) {
            errorSnackbar('enter_password'.tr);
          } else {
            loginUser(context);
          }
        } else {
          NetworkUtils.noInternetSnackbar();
        }
      },
    );
  }

  loginUser(BuildContext context) async {

    // loadingIndicator(context);
    Map<String, String> map = {
      AppConstant.emailKey: emailTextController.text.trim(),
      AppConstant.passwordKey: passwordTextController.text.trim()
    };

    print("called");
    var response = await ApiClient.postFormData(context: context,url: URL.loginURL, body: map);
    if (response != null) {
      loginModel = loginModelFromJson(response);
      prefs.setString(AppConstant.loginDataKey, json.encode(loginModel.toJson()));
      prefs.setString(AppConstant.token_S, loginModel.token);
      Get.offAll(HomePage());
    }
  }


}