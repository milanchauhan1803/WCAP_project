import 'package:ecommerce_app/model/customerBillingAddress.dart';
import 'package:ecommerce_app/model/lineItems.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'customerShippingAddress.dart';

part 'order.g.dart';

@JsonSerializable()
class Order extends ChangeNotifier {

  final int id;
  final String status;
  final String total;
  final String createdDate;
  final String number;
  @JsonKey(name: 'order_key')
  final String orderKey;
  final List<LineItems> line_items;
  final CustomerBillingAddress billing;
  final CustomerShippingAddress shipping;
  final String shipping_total;
  final String discount_total;
  final String total_tax;

  Order({
    required this.id,
    required this.status,
    required this.total,
    required this.createdDate,
    required this.number,
    required this.orderKey,
    required this.line_items,
    required this.billing,
    required this.shipping,
    required this.shipping_total,
    required this.discount_total,
    required this.total_tax,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
