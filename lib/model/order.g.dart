// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int,
      status: json['status'] as String,
      total: json['total'] as String,
      createdDate: json['date_created'] as String,
      number: json['number'] as String,
      orderKey: json['order_key'] as String,
      line_items: (json['line_items'] as List<dynamic>)
          .map((e) => LineItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      billing: CustomerBillingAddress.fromJson(json['billing']),
      shipping: CustomerShippingAddress.fromJson(json['shipping']),
      shipping_total: json['shipping_total'] as String,
      discount_total: json['discount_total'] as String,
      total_tax: json['total_tax'] as String,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'total': instance.total,
      'date_created': instance.createdDate,
      'number': instance.number,
      'order_key': instance.orderKey,
      'line_items': instance.line_items,
      'billing': instance.billing,
      'shipping': instance.shipping,
      'shipping_total': instance.shipping_total,
      'discount_total': instance.discount_total,
      'total_tax': instance.total_tax,
    };
