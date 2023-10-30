// To parse this JSON data, do
//
//     final cartErrorModel = cartErrorModelFromJson(jsonString);

import 'dart:convert';

CartErrorModel cartErrorModelFromJson(String str) => CartErrorModel.fromJson(json.decode(str));

String cartErrorModelToJson(CartErrorModel data) => json.encode(data.toJson());

class CartErrorModel {
  CartErrorModel({
    this.success,
    this.statusCode,
    this.code,
    this.message,
    this.data,
  });

  bool? success;
  String? statusCode;
  dynamic code;
  String? message;
  List<dynamic>? data;

  factory CartErrorModel.fromJson(Map<String, dynamic> json) => CartErrorModel(
    success: json["success"],
    statusCode: json["statusCode"],
    code: json["code"],
    message: json["message"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "statusCode": statusCode,
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x)),
  };
}
