import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'customerBillingAddress.g.dart';

@JsonSerializable()
class CustomerBillingAddress with ChangeNotifier {
  final String firstName;
  final String lastName;
  //final String company;
  final String address1;
  final String address2;
  final String city;
  final String postcode;
  final String country;
  final String state;
  final String email;
  final String phone;

  CustomerBillingAddress({
    required this.firstName,
    required this.lastName,
    //required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.postcode,
    required this.country,
    required this.state,
    required this.email,
    required this.phone,});

  factory CustomerBillingAddress.fromJson(Map<String, dynamic> json) =>
      _$BillingAddressFromJson(json);
  Map<String, dynamic> toJson() => _$BillingAddressToJson(this);

}