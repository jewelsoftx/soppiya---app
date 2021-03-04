// To parse this JSON data, do
//
//     final successResponse = successResponseFromJson(jsonString);

import 'dart:convert';

SuccessResponse successResponseFromJson(String str) => SuccessResponse.fromJson(json.decode(str));

String successResponseToJson(SuccessResponse data) => json.encode(data.toJson());

class SuccessResponse {
  SuccessResponse({
    this.success,
  });

  String success;

  factory SuccessResponse.fromJson(Map<String, dynamic> json) => SuccessResponse(
    success: json["Success"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
  };
}
