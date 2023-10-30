import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'itemImage.g.dart';

@JsonSerializable()
class ItemImage extends ChangeNotifier {

  final String id;
  final String src;

  ItemImage({
  required this.id,
  required this.src,
  });

  factory ItemImage.fromJson(Map<String, dynamic> json) => _$ItemImageFromJson(json);
  Map<String, dynamic> toJson() => _$ItemImageToJson(this);
}