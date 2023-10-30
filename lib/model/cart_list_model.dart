// To parse this JSON data, do
//
//     final cartListModel = cartListModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
CartListModel cartListModelFromJson(String str) => CartListModel.fromJson(json.decode(str));

String cartListModelToJson(CartListModel data) => json.encode(data.toJson());

class CartListModel extends ChangeNotifier{
  CartListModel({
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
  List<dynamic>? notices;

  factory CartListModel.fromJson(Map<String, dynamic> json) => CartListModel(
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
    notices: json["notices"] != null ? List<dynamic>.from(json["notices"].map((x) => x)) : json["notices"],
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
    "notices": List<dynamic>.from(notices!.map((x) => x)),
  };
}

class Currency extends ChangeNotifier{
  Currency({
    this.currencyCode,
    this.currencySymbol,
    this.currencyMinorUnit,
    this.currencyDecimalSeparator,
    this.currencyThousandSeparator,
    this.currencyPrefix,
    this.currencySuffix,
  });

  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
    currencyMinorUnit: json["currency_minor_unit"],
    currencyDecimalSeparator: json["currency_decimal_separator"],
    currencyThousandSeparator: json["currency_thousand_separator"],
    currencyPrefix: json["currency_prefix"],
    currencySuffix: json["currency_suffix"],
  );

  Map<String, dynamic> toJson() => {
    "currency_code": currencyCode,
    "currency_symbol": currencySymbol,
    "currency_minor_unit": currencyMinorUnit,
    "currency_decimal_separator": currencyDecimalSeparator,
    "currency_thousand_separator": currencyThousandSeparator,
    "currency_prefix": currencyPrefix,
    "currency_suffix": currencySuffix,
  };
}

class CustomerCart extends ChangeNotifier{
  CustomerCart({
    this.billingAddress,
    this.shippingAddress,
  });

  BillingAddress? billingAddress;
  ShippingAddress? shippingAddress;

  factory CustomerCart.fromJson(Map<String, dynamic> json) => CustomerCart(
    billingAddress: BillingAddress.fromJson(json["billing_address"]),
    shippingAddress: ShippingAddress.fromJson(json["shipping_address"]),
  );

  Map<String, dynamic> toJson() => {
    "billing_address": billingAddress?.toJson(),
    "shipping_address": shippingAddress?.toJson(),
  };
}

class BillingAddress extends ChangeNotifier{
  BillingAddress({
    this.billingFirstName,
    this.billingLastName,
    this.billingCompany,
    this.billingCountry,
    this.billingAddress1,
    this.billingAddress2,
    this.billingCity,
    this.billingState,
    this.billingPostcode,
    this.billingPhone,
    this.billingEmail,
  });

  String? billingFirstName;
  String? billingLastName;
  String? billingCompany;
  String? billingCountry;
  String? billingAddress1;
  String? billingAddress2;
  String? billingCity;
  String? billingState;
  String? billingPostcode;
  String? billingPhone;
  String? billingEmail;

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
    billingFirstName: json["billing_first_name"],
    billingLastName: json["billing_last_name"],
    billingCompany: json["billing_company"],
    billingCountry: json["billing_country"],
    billingAddress1: json["billing_address_1"],
    billingAddress2: json["billing_address_2"],
    billingCity: json["billing_city"],
    billingState: json["billing_state"],
    billingPostcode: json["billing_postcode"],
    billingPhone: json["billing_phone"],
    billingEmail: json["billing_email"],
  );

  Map<String, dynamic> toJson() => {
    "billing_first_name": billingFirstName,
    "billing_last_name": billingLastName,
    "billing_company": billingCompany,
    "billing_country": billingCountry,
    "billing_address_1": billingAddress1,
    "billing_address_2": billingAddress2,
    "billing_city": billingCity,
    "billing_state": billingState,
    "billing_postcode": billingPostcode,
    "billing_phone": billingPhone,
    "billing_email": billingEmail,
  };
}

class ShippingAddress extends ChangeNotifier{
  ShippingAddress({
    this.shippingFirstName,
    this.shippingLastName,
    this.shippingCompany,
    this.shippingCountry,
    this.shippingAddress1,
    this.shippingAddress2,
    this.shippingCity,
    this.shippingState,
    this.shippingPostcode,
  });

  String? shippingFirstName;
  String? shippingLastName;
  String? shippingCompany;
  String? shippingCountry;
  String? shippingAddress1;
  String? shippingAddress2;
  String? shippingCity;
  String? shippingState;
  String? shippingPostcode;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
    shippingFirstName: json["shipping_first_name"],
    shippingLastName: json["shipping_last_name"],
    shippingCompany: json["shipping_company"],
    shippingCountry: json["shipping_country"],
    shippingAddress1: json["shipping_address_1"],
    shippingAddress2: json["shipping_address_2"],
    shippingCity: json["shipping_city"],
    shippingState: json["shipping_state"],
    shippingPostcode: json["shipping_postcode"],
  );

  Map<String, dynamic> toJson() => {
    "shipping_first_name": shippingFirstName,
    "shipping_last_name": shippingLastName,
    "shipping_company": shippingCompany,
    "shipping_country": shippingCountry,
    "shipping_address_1": shippingAddress1,
    "shipping_address_2": shippingAddress2,
    "shipping_city": shippingCity,
    "shipping_state": shippingState,
    "shipping_postcode": shippingPostcode,
  };
}

class Item extends ChangeNotifier{
  Item({
    this.itemKey,
    this.id,
    this.name,
    this.title,
    this.price,
    this.quantity,
    this.totals,
    this.slug,
    this.meta,
    this.backorders,
    this.cartItemData,
    this.featuredImage,
  });

  String? itemKey;
  int? id;
  String? name;
  String? title;
  String? price;
  Quantity? quantity;
  ItemTotals? totals;
  String? slug;
  ItemMeta? meta;
  String? backorders;
  List<dynamic>? cartItemData;
  String? featuredImage;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemKey: json["item_key"],
    id: json["id"],
    name: json["name"],
    title: json["title"],
    price: json["price"],
    quantity: Quantity.fromJson(json["quantity"]),
    totals: ItemTotals.fromJson(json["totals"]),
    slug: json["slug"],
    meta: ItemMeta.fromJson(json["meta"]),
    backorders: json["backorders"],
    cartItemData: List<dynamic>.from(json["cart_item_data"].map((x) => x)),
    featuredImage: json["featured_image"],
  );

  Map<String, dynamic> toJson() => {
    "item_key": itemKey,
    "id": id,
    "name": name,
    "title": title,
    "price": price,
    "quantity": quantity?.toJson(),
    "totals": totals?.toJson(),
    "slug": slug,
    "meta": meta?.toJson(),
    "backorders": backorders,
    "cart_item_data": List<dynamic>.from(cartItemData!.map((x) => x)),
    "featured_image": featuredImage,
  };
}

class ItemMeta extends ChangeNotifier{
  ItemMeta({
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

  factory ItemMeta.fromJson(Map<String, dynamic> json) => ItemMeta(
    productType: json["product_type"],
    sku: json["sku"],
    dimensions: Dimensions.fromJson(json["dimensions"]),
    weight: json["weight"],
    variation: List<dynamic>.from(json["variation"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "product_type": productType,
    "sku": sku,
    "dimensions": dimensions?.toJson(),
    "weight": weight,
    "variation": List<dynamic>.from(variation!.map((x) => x)),
  };
}

class Dimensions extends ChangeNotifier{
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

class Quantity extends ChangeNotifier{
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

class ItemTotals extends ChangeNotifier{
  ItemTotals({
    this.subtotal,
    this.subtotalTax,
    this.total,
    this.tax,
  });

  String? subtotal;
  int? subtotalTax;
  int? total;
  int? tax;

  factory ItemTotals.fromJson(Map<String, dynamic> json) => ItemTotals(
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

class RemovedItem extends ChangeNotifier{
  RemovedItem({
    this.itemKey,
    this.id,
    this.name,
    this.title,
    this.price,
    this.quantity,
    this.totals,
    this.slug,
    this.meta,
    this.backorders,
    this.cartItemData,
    this.featuredImage,
  });

  String? itemKey;
  int? id;
  String? name;
  String? title;
  String? price;
  int? quantity;
  ItemTotals? totals;
  String? slug;
  RemovedItemMeta? meta;
  String? backorders;
  List<dynamic>? cartItemData;
  String? featuredImage;

  factory RemovedItem.fromJson(Map<String, dynamic> json) => RemovedItem(
    itemKey: json["item_key"],
    id: json["id"],
    name: json["name"],
    title: json["title"],
    price: json["price"],
    quantity: json["quantity"],
    totals: ItemTotals.fromJson(json["totals"]),
    slug: json["slug"],
    meta: RemovedItemMeta.fromJson(json["meta"]),
    backorders: json["backorders"],
    cartItemData: List<dynamic>.from(json["cart_item_data"].map((x) => x)),
    featuredImage: json["featured_image"],
  );

  Map<String, dynamic> toJson() => {
    "item_key": itemKey,
    "id": id,
    "name": name,
    "title": title,
    "price": price,
    "quantity": quantity,
    "totals": totals?.toJson(),
    "slug": slug,
    "meta": meta?.toJson(),
    "backorders": backorders,
    "cart_item_data": List<dynamic>.from(cartItemData!.map((x) => x)),
    "featured_image": featuredImage,
  };
}

class RemovedItemMeta extends ChangeNotifier{
  RemovedItemMeta({
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
  dynamic variation;

  factory RemovedItemMeta.fromJson(Map<String, dynamic> json) => RemovedItemMeta(
    productType: json["product_type"],
    sku: json["sku"],
    dimensions: Dimensions.fromJson(json["dimensions"]),
    weight: json["weight"],
    variation: json["variation"],
  );

  Map<String, dynamic> toJson() => {
    "product_type": productType,
    "sku": sku,
    "dimensions": dimensions?.toJson(),
    "weight": weight,
    "variation": variation,
  };
}

class VariationClass extends ChangeNotifier{
  VariationClass({
    this.color,
    this.logo,
  });

  String? color;
  String? logo;

  factory VariationClass.fromJson(Map<String, dynamic> json) => VariationClass(
    color: json["Color"],
    logo: json["Logo"],
  );

  Map<String, dynamic> toJson() => {
    "Color": color,
    "Logo": logo,
  };
}

class CartListModelTotals extends ChangeNotifier{
  CartListModelTotals({
    this.subtotal,
    this.subtotalTax,
    this.feeTotal,
    this.feeTax,
    this.discountTotal,
    this.discountTax,
    this.shippingTotal,
    this.shippingTax,
    this.total,
    this.totalTax,
  });

  String? subtotal;
  String? subtotalTax;
  String? feeTotal;
  String? feeTax;
  String? discountTotal;
  String? discountTax;
  String? shippingTotal;
  String? shippingTax;
  String? total;
  String? totalTax;

  factory CartListModelTotals.fromJson(Map<String, dynamic> json) => CartListModelTotals(
    subtotal: json["subtotal"],
    subtotalTax: json["subtotal_tax"],
    feeTotal: json["fee_total"],
    feeTax: json["fee_tax"],
    discountTotal: json["discount_total"],
    discountTax: json["discount_tax"],
    shippingTotal: json["shipping_total"],
    shippingTax: json["shipping_tax"],
    total: json["total"],
    totalTax: json["total_tax"],
  );

  Map<String, dynamic> toJson() => {
    "subtotal": subtotal,
    "subtotal_tax": subtotalTax,
    "fee_total": feeTotal,
    "fee_tax": feeTax,
    "discount_total": discountTotal,
    "discount_tax": discountTax,
    "shipping_total": shippingTotal,
    "shipping_tax": shippingTax,
    "total": total,
    "total_tax": totalTax,
  };
}

class Notices extends ChangeNotifier{
  Notices({
    this.success,
  });

  List<String>? success;

  factory Notices.fromJson(Map<String, dynamic> json) => Notices(
    success: List<String>.from(json["success"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": List<dynamic>.from(success!.map((x) => x)),
  };
}
