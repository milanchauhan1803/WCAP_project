import 'package:ecommerce_app/model/customerBillingAddress.dart';
import 'package:ecommerce_app/model/customerShippingAddress.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer with ChangeNotifier {
  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String role;
  final String username;
  final CustomerBillingAddress billing;
  final CustomerShippingAddress shipping;

  Customer({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.role,
    required this.username,
    required this.billing,
    required this.shipping,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);

}