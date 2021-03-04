// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    this.error,
  });

  String error;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    error: json["Error"],
  );

  Map<String, dynamic> toJson() => {
    "Error": error,
  };
}
