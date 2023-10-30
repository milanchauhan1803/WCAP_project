import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'customerShippingAddress.g.dart';

@JsonSerializable()
class CustomerShippingAddress with ChangeNotifier {
  final String firstName;
  final String lastName;
  //final String company;
  final String address1;
  final String address2;
  final String city;
  final String postcode;
  final String country;
  final String state;
  final String phone;

  CustomerShippingAddress({
    required this.firstName,
    required this.lastName,
    //required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.postcode,
    required this.country,
    required this.state,
    required this.phone,});

  factory CustomerShippingAddress.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingAddressToJson(this);

}