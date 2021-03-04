import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoppiya_admin/main.dart';
import 'package:shoppiya_admin/utils/AppConstant.dart';
import 'package:shoppiya_admin/view/welcom/welcome_screen.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class ApiClient {
  static var header = {'token': '${prefs.getString(AppConstant.tokenS)}'};

  static Future getFormData({
    @required String url,
    @required bool enableHeader,
  }) async {
    // loadingIndicator();
    var uri = Uri.parse(url);
    var headers = header;
    var request = http.Request('GET', uri);

    if (enableHeader) {
      request.headers.addAll(headers);
    }

    http.StreamedResponse streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      showData(url: url, method: Method.GET, response: response.body.toString());

      if (responseData[AppConstant.errorKey] == "invalid access") {
        Get.offAll(WelcomeScreen());
      }
      if (responseData[AppConstant.errorKey] == "token expired. login again") {
        Get.offAll(WelcomeScreen());
      }
      if (responseData.containsKey(AppConstant.errorKey)) {
        errorSnackbar(responseData[AppConstant.errorKey]);
        return null;
      } else {
        return response.body;
      }
    } else {
      errorSnackbar("internal_server_error".tr);
      return null;
    }
  }

  static Future postFormDataWithFile(
      {@required String url,
      Map<String, String> body,
      Method method = Method.POST,
      bool enableHeader = false,
      String fileKey,
      File files}) async {
    var uri = Uri.parse(url);
    var request;

    try {
      if (enableHeader) {
        request = new http.MultipartRequest("POST", uri);
        request.headers.addAll(header);
        request.fields.addAll(body);
        if (files != null) {
          request.files.add(await http.MultipartFile.fromPath(fileKey, files.path));
        }
      } else {
        request = new http.MultipartRequest("POST", uri);
        request.fields.addAll(body);
        if (files != null) {
          request.files.add(await http.MultipartFile.fromPath(fileKey, files.path));
        }
      }

      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      Get.back();
      final Map<String, dynamic> responseData = json.decode(response.body);
      showData(url: url, body: body, method: method, response: response.body.toString());
      if (response.statusCode == 200) {
        if (responseData[AppConstant.errorKey] == "invalid access") {
          Get.offAll(WelcomeScreen());
        }
        if (responseData[AppConstant.errorKey] == "token expired. login again") {
          Get.offAll(WelcomeScreen());
        }
        if (responseData.containsKey(AppConstant.errorKey)) {
          errorSnackbar(responseData[AppConstant.errorKey]);

          return null;
        } else {
          return response.body;
        }
      } else {
        errorSnackbar("internal_server_error".tr);
        return null;
      }
    } catch (e) {
      errorSnackbar("something_wrong".tr);

      return null;
    }
  }

  static Future postFormData({
    @required String url,
    Map<String, String> body,
    Method method = Method.POST,
    bool enableHeader = false,
  }) async {
    var uri = Uri.parse(url);
    var request;

    try {
      if (enableHeader) {
        request = new http.MultipartRequest("POST", uri)..headers.addAll(header)..fields.addAll(body);
      } else {
        request = new http.MultipartRequest("POST", uri)..fields.addAll(body);
      }
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      Get.back();
      final Map<String, dynamic> responseData = json.decode(response.body);
      showData(url: url, body: body, method: method, response: response.body.toString());
      if (response.statusCode == 200) {
        if (responseData[AppConstant.errorKey] == "invalid access") {
          Get.offAll(WelcomeScreen());
        }
        if (responseData[AppConstant.errorKey] == "token expired. login again") {
          Get.offAll(WelcomeScreen());
        } else {
          return response.body;
        }
      } else {
        errorSnackbar("internal_server_error".tr);
        return null;
      }
    } catch (e) {
      errorSnackbar("something_wrong".tr);
      return null;
    }
  }

  static void showData({String url, var body, String response, Method method}) {
    if (!kReleaseMode) {
      print("URL = $url");
      print("Body = $body");
      print("Method = $method");
      print("Response = $response");
    }
  }
}
