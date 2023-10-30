import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'itemImage.dart';

part 'lineItems.g.dart';

@JsonSerializable()
class LineItems extends ChangeNotifier {

  final int id;
  final String name;
  final int quantity;
  final String total;
  final ItemImage image;

  LineItems({
    required this.id,
    required this.name,
    required this.quantity,
    required this.total,
    required this.image
  });

  factory LineItems.fromJson(Map<String, dynamic> json) => _$LineItemsFromJson(json);
  Map<String, dynamic> toJson() => _$LineItemsToJson(this);
}