import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coupon.g.dart';

@JsonSerializable()
class Coupon with ChangeNotifier {
  final int id;
  final String code;
  final String amount;
  final String discount_type;

  Coupon({
    required this.id,
    required this.code,
    required this.amount,
    required this.discount_type,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) =>
      _$CouponFromJson(json);
  Map<String, dynamic> toJson() => _$CouponToJson(this);

}