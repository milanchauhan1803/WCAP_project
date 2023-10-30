part of 'category.dart';

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: json['id'] as int,
  name: json['name'] as String,
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};