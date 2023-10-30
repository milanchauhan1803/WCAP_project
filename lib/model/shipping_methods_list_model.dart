// To parse this JSON data, do
//
//     final shippingMethodsListModel = shippingMethodsListModelFromJson(jsonString);

import 'dart:convert';

List<ShippingMethodsListModel> shippingMethodsListModelFromJson(String str) => List<ShippingMethodsListModel>.from(json.decode(str).map((x) => ShippingMethodsListModel.fromJson(x)));

String shippingMethodsListModelToJson(List<ShippingMethodsListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShippingMethodsListModel {
  ShippingMethodsListModel({
    this.id,
    this.title,
    this.description,
    this.links,
  });

  String? id;
  String? title;
  String? description;
  Links? links;

  factory ShippingMethodsListModel.fromJson(Map<String, dynamic> json) => ShippingMethodsListModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "_links": links!.toJson(),
  };
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection>? self;
  List<Collection>? collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))),
    collection: List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self!.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection!.map((x) => x.toJson())),
  };
}

class Collection {
  Collection({
    this.href,
  });

  String? href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}
