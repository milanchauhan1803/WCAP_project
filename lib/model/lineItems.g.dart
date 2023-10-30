part of 'lineItems.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LineItems _$LineItemsFromJson(Map<String, dynamic> json) => LineItems(
  id: json['id'] as int,
  name: json['name'] as String,
  quantity: json['quantity'] as int,
  total: json['total'] as String,
  image: ItemImage.fromJson(json['image']),
);

Map<String, dynamic> _$LineItemsToJson(LineItems instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'quantity': instance.quantity,
  'total': instance.total,
  'image': instance.image,
};