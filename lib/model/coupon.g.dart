part of 'coupon.dart';

Coupon _$CouponFromJson(Map<String, dynamic> json) => Coupon(
  id: json['id'] as int,
  code: json['code'] as String,
  amount: json['amount'] as String,
  discount_type: json['discount_type'] as String,
);

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'amount': instance.amount,
  'discount_type': instance.discount_type,
};