part of 'customer.dart';

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
  id: json['id'] as int,
  email: json['email'] as String,
  first_name: json['first_name'] as String,
  last_name: json['last_name'] as String,
  role: json['role'] as String,
  username: json['username'] as String,
  billing: CustomerBillingAddress.fromJson(json['billing']),
  shipping: CustomerShippingAddress.fromJson(json['shipping']),
);

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'first_name': instance.first_name,
  'last_name': instance.last_name,
  'role': instance.role,
  'username': instance.username,
  'billing': instance.billing,
  'shipping': instance.shipping,
};