// To parse this JSON data, do
//
//     final placeOrderErrorModel = placeOrderErrorModelFromJson(jsonString);

import 'dart:convert';

PlaceOrderErrorModel placeOrderErrorModelFromJson(String str) => PlaceOrderErrorModel.fromJson(json.decode(str));

String placeOrderErrorModelToJson(PlaceOrderErrorModel data) => json.encode(data.toJson());

class PlaceOrderErrorModel {
  PlaceOrderErrorModel({
    this.code,
    this.message,
    this.data,
  });

  String? code;
  String? message;
  Data? data;

  factory PlaceOrderErrorModel.fromJson(Map<String, dynamic> json) => PlaceOrderErrorModel(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.status,
  });

  dynamic status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
  };
}
