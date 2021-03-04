import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppiya_admin/main.dart';
import 'package:shoppiya_admin/model/error_response.dart';
import 'package:shoppiya_admin/model/login_model.dart';
import 'package:shoppiya_admin/model/success_response.dart';
import 'package:shoppiya_admin/networking/api_client.dart';
import 'package:shoppiya_admin/networking/network_utils.dart';
import 'package:shoppiya_admin/networking/url.dart';
import 'package:shoppiya_admin/utils/AppConstant.dart';
import 'package:shoppiya_admin/view/home.dart';

class AuthController extends GetxController {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController referralTextController = TextEditingController();

  // email field
  var isEmailError = false.obs;
  var emailErrorText = "".obs;

  // password field
  var isPasswordError = false.obs;
  var passwordErrorText = "".obs;

  // loading
  var isLoading = false.obs;

  // login error message
  var loginMessage = "".obs;

  // show error message
  var isShowApiMessage = false.obs;

  var isColorGreen = false.obs;



  void doReset() {
    String email = emailTextController.text.toString();
    isEmailError.value = false;
    isShowApiMessage.value = false;
    isColorGreen.value  = false;

    NetworkUtils.checkInternet().then(
          (intenet) {
        if (intenet != null && intenet) {
          if (email.isEmpty) {
            isEmailError.value = true;
            emailErrorText.value = "Email field required ";
          } else if (!GetUtils.isEmail(email)) {
            isEmailError.value = true;
            emailErrorText.value = "Valid Email required ";
          } else {
           resetApi();
          }
        } else {
          NetworkUtils.noInternetSnackbar();
        }
      },
    );
  }

  void resetApi() async{

    isLoading.value = true;
    Map<String, String> map = {
      AppConstant.emailKey: emailTextController.text.trim(),
    };

    var response = await ApiClient.postFormData(url: URL.resetURL, body: map);
    isLoading.value = false;
    if (response != null) {
      if (response.contains(AppConstant.errorKey)) {
        isShowApiMessage.value = true;
        ErrorResponse errorResponse = errorResponseFromJson(response);
        loginMessage.value = errorResponse.error;
      } else {
        isShowApiMessage.value = true;
        isColorGreen.value = true;
        SuccessResponse successResponse = successResponseFromJson(response);
        loginMessage.value = successResponse.success;
      }
    }
  }

  void doSignUp() {
    String email = emailTextController.text.toString();
    isEmailError.value = false;
    isShowApiMessage.value = false;
    isColorGreen.value  = false;

    NetworkUtils.checkInternet().then(
      (intenet) {
        if (intenet != null && intenet) {
          if (email.isEmpty) {
            isEmailError.value = true;
            emailErrorText.value = "Email field required ";
          } else if (!GetUtils.isEmail(email)) {
            isEmailError.value = true;
            emailErrorText.value = "Valid Email required ";
          } else {
            signUpUser();
          }
        } else {
          NetworkUtils.noInternetSnackbar();
        }
      },
    );
  }

  void signUpUser() async {
    isLoading.value = true;
    Map<String, String> map = {
      AppConstant.emailKey: emailTextController.text.trim(),
      AppConstant.referralKey: referralTextController.text.trim() // need to change referral key
    };

    var response = await ApiClient.postFormData(url: URL.signUpURL, body: map);
    isLoading.value = false;
    if (response != null) {
      if (response.contains(AppConstant.errorKey)) {
        isShowApiMessage.value = true;
        ErrorResponse errorResponse = errorResponseFromJson(response);
        loginMessage.value = errorResponse.error;
      } else {
        isShowApiMessage.value = true;
        isColorGreen.value = true;
        SuccessResponse successResponse = successResponseFromJson(response);
        loginMessage.value = successResponse.success;
      }
    }
  }

  // login api call
  void doLoginApiCall() {
    String email = emailTextController.text.toString();
    String pass = passwordTextController.text.toString();

    isEmailError.value = false;
    isPasswordError.value = false;
    isShowApiMessage.value = false;
    isColorGreen.value = false;

    NetworkUtils.checkInternet().then(
      (intenet) {
        if (intenet != null && intenet) {
          if (email.isEmpty) {
            isEmailError.value = true;
            emailErrorText.value = "Email field required ";
          } else if (!GetUtils.isEmail(email)) {
            isEmailError.value = true;
            emailErrorText.value = "Valid Email required ";
          } else if (pass.isEmpty) {
            isPasswordError.value = true;
            passwordErrorText.value = "Password field required";
          } else {
            loginUser();
          }
        } else {
          NetworkUtils.noInternetSnackbar();
        }
      },
    );
  }

  void loginUser() async {
    isLoading.value = true;
    Map<String, String> map = {
      AppConstant.emailKey: emailTextController.text.trim(),
      AppConstant.passwordKey: passwordTextController.text.trim()
    };

    var response = await ApiClient.postFormData(url: URL.loginURL, body: map);
    isLoading.value = false;
    if (response != null) {
      if (response.contains(AppConstant.errorKey)) {
        isShowApiMessage.value = true;
        isColorGreen.value = false;
        ErrorResponse errorResponse = errorResponseFromJson(response);
        loginMessage.value = errorResponse.error;
      } else {
        loginModel = loginModelFromJson(response);
        prefs.setString(AppConstant.loginDataKey, json.encode(loginModel.toJson()));
        prefs.setString(AppConstant.tokenS, loginModel.token);
        Get.offAll(HomePage());
      }
    }
  }
}
