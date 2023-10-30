// To parse this JSON data, do
//
//     final createOrderModel = createOrderModelFromJson(jsonString);

import 'dart:convert';

CreateOrderModel createOrderModelFromJson(String str) => CreateOrderModel.fromJson(json.decode(str));

String createOrderModelToJson(CreateOrderModel data) => json.encode(data.toJson());

class CreateOrderModel {
  CreateOrderModel({
    this.id,
    this.parentId,
    this.status,
    this.currency,
    this.version,
    this.pricesIncludeTax,
    /*this.dateCreated,
    this.dateModified,*/
    this.discountTotal,
    this.discountTax,
    this.shippingTotal,
    this.shippingTax,
    this.cartTax,
    this.total,
    this.totalTax,
    this.customerId,
    this.orderKey,
    this.billing,
    this.shipping,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.transactionId,
    this.customerIpAddress,
    this.customerUserAgent,
    this.createdVia,
    this.customerNote,
    this.dateCompleted,
    this.datePaid,
    this.cartHash,
    this.number,
    this.metaData,
    this.lineItems,
    this.taxLines,
    this.shippingLines,
    this.feeLines,
    this.couponLines,
    this.refunds,
    this.paymentUrl,
    this.isEditable,
    this.needsPayment,
    this.needsProcessing,
    this.dateCreatedGmt,
    this.dateModifiedGmt,
    this.dateCompletedGmt,
    this.datePaidGmt,
    this.currencySymbol,
    this.links,
  });

  int? id;
  int? parentId;
  String? status;
  String? currency;
  String? version;
  bool? pricesIncludeTax;
  /*DateTime? dateCreated;
  DateTime? dateModified;*/
  String? discountTotal;
  String? discountTax;
  String? shippingTotal;
  String? shippingTax;
  String? cartTax;
  String? total;
  String? totalTax;
  int? customerId;
  String? orderKey;
  Ing? billing;
  Ing? shipping;
  String? paymentMethod;
  String? paymentMethodTitle;
  String? transactionId;
  String? customerIpAddress;
  String? customerUserAgent;
  String? createdVia;
  String? customerNote;
  dynamic dateCompleted;
  dynamic datePaid;
  String? cartHash;
  String? number;
  List<dynamic>? metaData;
  List<dynamic>? lineItems;
  List<dynamic>? taxLines;
  List<dynamic>? shippingLines;
  List<dynamic>? feeLines;
  List<dynamic>? couponLines;
  List<dynamic>? refunds;
  String? paymentUrl;
  bool? isEditable;
  bool? needsPayment;
  bool? needsProcessing;
  DateTime? dateCreatedGmt;
  DateTime? dateModifiedGmt;
  dynamic dateCompletedGmt;
  dynamic datePaidGmt;
  String? currencySymbol;
  Links? links;

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) => CreateOrderModel(
    id: json["id"],
    parentId: json["parent_id"],
    status: json["status"],
    currency: json["currency"],
    version: json["version"],
    pricesIncludeTax: json["prices_include_tax"],
   /* dateCreated: DateTime.parse(json["date_created"]),
    dateModified: DateTime.parse(json["date_modified"]),*/
    discountTotal: json["discount_total"],
    discountTax: json["discount_tax"],
    shippingTotal: json["shipping_total"],
    shippingTax: json["shipping_tax"],
    cartTax: json["cart_tax"],
    total: json["total"],
    totalTax: json["total_tax"],
    customerId: json["customer_id"],
    orderKey: json["order_key"],
    billing: Ing.fromJson(json["billing"]),
    shipping: Ing.fromJson(json["shipping"]),
    paymentMethod: json["payment_method"],
    paymentMethodTitle: json["payment_method_title"],
    transactionId: json["transaction_id"],
    customerIpAddress: json["customer_ip_address"],
    customerUserAgent: json["customer_user_agent"],
    createdVia: json["created_via"],
    customerNote: json["customer_note"],
    dateCompleted: json["date_completed"],
    datePaid: json["date_paid"],
    cartHash: json["cart_hash"],
    number: json["number"],
    metaData: List<dynamic>.from(json["meta_data"].map((x) => x)),
    lineItems: List<dynamic>.from(json["line_items"].map((x) => x)),
    taxLines: List<dynamic>.from(json["tax_lines"].map((x) => x)),
    shippingLines: List<dynamic>.from(json["shipping_lines"].map((x) => x)),
    feeLines: List<dynamic>.from(json["fee_lines"].map((x) => x)),
    couponLines: List<dynamic>.from(json["coupon_lines"].map((x) => x)),
    refunds: List<dynamic>.from(json["refunds"].map((x) => x)),
    paymentUrl: json["payment_url"],
    isEditable: json["is_editable"],
    needsPayment: json["needs_payment"],
    needsProcessing: json["needs_processing"],
    dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
    dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
    dateCompletedGmt: json["date_completed_gmt"],
    datePaidGmt: json["date_paid_gmt"],
    currencySymbol: json["currency_symbol"],
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "status": status,
    "currency": currency,
    "version": version,
    "prices_include_tax": pricesIncludeTax,
    /*"date_created": dateCreated!.toIso8601String(),
    "date_modified": dateModified!.toIso8601String(),*/
    "discount_total": discountTotal,
    "discount_tax": discountTax,
    "shipping_total": shippingTotal,
    "shipping_tax": shippingTax,
    "cart_tax": cartTax,
    "total": total,
    "total_tax": totalTax,
    "customer_id": customerId,
    "order_key": orderKey,
    "billing": billing!.toJson(),
    "shipping": shipping!.toJson(),
    "payment_method": paymentMethod,
    "payment_method_title": paymentMethodTitle,
    "transaction_id": transactionId,
    "customer_ip_address": customerIpAddress,
    "customer_user_agent": customerUserAgent,
    "created_via": createdVia,
    "customer_note": customerNote,
    "date_completed": dateCompleted,
    "date_paid": datePaid,
    "cart_hash": cartHash,
    "number": number,
    "meta_data": List<dynamic>.from(metaData!.map((x) => x)),
    "line_items": List<dynamic>.from(lineItems!.map((x) => x)),
    "tax_lines": List<dynamic>.from(taxLines!.map((x) => x)),
    "shipping_lines": List<dynamic>.from(shippingLines!.map((x) => x)),
    "fee_lines": List<dynamic>.from(feeLines!.map((x) => x)),
    "coupon_lines": List<dynamic>.from(couponLines!.map((x) => x)),
    "refunds": List<dynamic>.from(refunds!.map((x) => x)),
    "payment_url": paymentUrl,
    "is_editable": isEditable,
    "needs_payment": needsPayment,
    "needs_processing": needsProcessing,
    "date_created_gmt": dateCreatedGmt!.toIso8601String(),
    "date_modified_gmt": dateModifiedGmt!.toIso8601String(),
    "date_completed_gmt": dateCompletedGmt,
    "date_paid_gmt": datePaidGmt,
    "currency_symbol": currencySymbol,
    "_links": links!.toJson(),
  };
}

class Ing {
  Ing({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? email;
  String? phone;

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
    firstName: json["first_name"],
    lastName: json["last_name"],
    company: json["company"],
    address1: json["address_1"],
    address2: json["address_2"],
    city: json["city"],
    state: json["state"],
    postcode: json["postcode"],
    country: json["country"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "company": company,
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "state": state,
    "postcode": postcode,
    "country": country,
    "email": email == null ? null : email,
    "phone": phone,
  };
}

class Links {
  Links({
    this.self,
    this.collection,
    this.customer,
  });

  List<Collection>? self;
  List<Collection>? collection;
  List<Collection>? customer;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))),
    collection: List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
    customer: List<Collection>.from(json["customer"].map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self!.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection!.map((x) => x.toJson())),
    "customer": List<dynamic>.from(customer!.map((x) => x.toJson())),
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
