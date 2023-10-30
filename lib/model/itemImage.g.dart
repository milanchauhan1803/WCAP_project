part of 'itemImage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


ItemImage _$ItemImageFromJson(Map<String, dynamic> json) => ItemImage(
  id: json['id'] as String,
  src: json['src'] as String,
);

Map<String, dynamic> _$ItemImageToJson(ItemImage instance) => <String, dynamic>{
  'id': instance.id,
  'src': instance.src,
};