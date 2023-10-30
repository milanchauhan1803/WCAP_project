// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'cart_list_model.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel extends ChangeNotifier{
  CartModel({
    this.cartHash,
    this.cartKey,
    this.currency,
    this.customer,
    this.items,
    this.itemCount,
    this.itemsWeight,
    this.coupons,
    this.needsPayment,
    this.needsShipping,
    this.shipping,
    this.fees,
    this.taxes,
    this.totals,
    //this.removedItems,
    this.crossSells,
    this.notices,
  });

  String? cartHash;
  String? cartKey;
  Currency? currency;
  CustomerCart? customer;
  List<Item>? items;
  int? itemCount;
  int? itemsWeight;
  List<dynamic>? coupons;
  bool? needsPayment;
  bool? needsShipping;
  List<dynamic>? shipping;
  List<dynamic>? fees;
  List<dynamic>? taxes;
  CartListModelTotals? totals;
  //List<RemovedItem>? removedItems;
  List<dynamic>? crossSells;
  Notices? notices;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    cartHash: json["cart_hash"],
    cartKey: json["cart_key"],
    currency: Currency.fromJson(json["currency"]),
    customer: CustomerCart.fromJson(json["customer"]),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    itemCount: json["item_count"],
    itemsWeight: json["items_weight"],
    coupons: List<dynamic>.from(json["coupons"].map((x) => x)),
    needsPayment: json["needs_payment"],
    needsShipping: json["needs_shipping"],
    shipping: List<dynamic>.from(json["shipping"].map((x) => x)),
    fees: List<dynamic>.from(json["fees"].map((x) => x)),
    taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
    totals: CartListModelTotals.fromJson(json["totals"]),
    //removedItems: List<RemovedItem>.from(json["removed_items"].map((x) => RemovedItem.fromJson(x))),
    crossSells: List<dynamic>.from(json["cross_sells"].map((x) => x)),
    notices: json["notices"] != null || json["notices"] != "[]" ? Notices.fromJson(json["notices"]) : json["notices"],
  );

  Map<String, dynamic> toJson() => {
    "cart_hash": cartHash,
    "cart_key": cartKey,
    "currency": currency?.toJson(),
    "customer": customer?.toJson(),
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "item_count": itemCount,
    "items_weight": itemsWeight,
    "coupons": List<dynamic>.from(coupons!.map((x) => x)),
    "needs_payment": needsPayment,
    "needs_shipping": needsShipping,
    "shipping": List<dynamic>.from(shipping!.map((x) => x)),
    "fees": List<dynamic>.from(fees!.map((x) => x)),
    "taxes": List<dynamic>.from(taxes!.map((x) => x)),
    "totals": totals?.toJson(),
    //"removed_items": List<dynamic>.from(removedItems!.map((x) => x.toJson())),
    "cross_sells": List<dynamic>.from(crossSells!.map((x) => x)),
    "notices": notices!.toJson(),
  };
}

class Meta {
  Meta({
    this.productType,
    this.sku,
    this.dimensions,
    this.weight,
    this.variation,
  });

  String? productType;
  String? sku;
  Dimensions? dimensions;
  int? weight;
  List<dynamic>? variation;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    productType: json["product_type"],
    sku: json["sku"],
    dimensions: Dimensions.fromJson(json["dimensions"]),
    weight: json["weight"],
    variation: List<dynamic>.from(json["variation"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "product_type": productType,
    "sku": sku,
    "dimensions": dimensions!.toJson(),
    "weight": weight,
    "variation": List<dynamic>.from(variation!.map((x) => x)),
  };
}

class Dimensions {
  Dimensions({
    this.length,
    this.width,
    this.height,
    this.unit,
  });

  String? length;
  String? width;
  String? height;
  String? unit;

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
    length: json["length"],
    width: json["width"],
    height: json["height"],
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "length": length,
    "width": width,
    "height": height,
    "unit": unit,
  };
}

class Quantity {
  Quantity({
    this.value,
    this.minPurchase,
    this.maxPurchase,
  });

  int? value;
  int? minPurchase;
  int? maxPurchase;

  factory Quantity.fromJson(Map<String, dynamic> json) => Quantity(
    value: json["value"],
    minPurchase: json["min_purchase"],
    maxPurchase: json["max_purchase"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "min_purchase": minPurchase,
    "max_purchase": maxPurchase,
  };
}

class TaxData {
  TaxData({
    this.subtotal,
    this.total,
  });

  List<dynamic>? subtotal;
  List<dynamic>? total;

  factory TaxData.fromJson(Map<String, dynamic> json) => TaxData(
    subtotal: List<dynamic>.from(json["subtotal"].map((x) => x)),
    total: List<dynamic>.from(json["total"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "subtotal": List<dynamic>.from(subtotal!.map((x) => x)),
    "total": List<dynamic>.from(total!.map((x) => x)),
  };
}

class Totals {
  Totals({
    this.subtotal,
    this.subtotalTax,
    this.total,
    this.tax,
  });

  dynamic subtotal;
  dynamic subtotalTax;
  dynamic total;
  dynamic tax;

  factory Totals.fromJson(Map<String, dynamic> json) => Totals(
    subtotal: json["subtotal"],
    subtotalTax: json["subtotal_tax"],
    total: json["total"],
    tax: json["tax"],
  );

  Map<String, dynamic> toJson() => {
    "subtotal": subtotal,
    "subtotal_tax": subtotalTax,
    "total": total,
    "tax": tax,
  };
}
