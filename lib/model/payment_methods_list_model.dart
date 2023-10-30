// To parse this JSON data, do
//
//     final paymentMethodsListModel = paymentMethodsListModelFromJson(jsonString);

import 'dart:convert';

List<PaymentMethodsListModel> paymentMethodsListModelFromJson(String str) => List<PaymentMethodsListModel>.from(json.decode(str).map((x) => PaymentMethodsListModel.fromJson(x)));

String paymentMethodsListModelToJson(List<PaymentMethodsListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentMethodsListModel {
  PaymentMethodsListModel({
    this.id,
    this.title,
    this.description,
    this.order,
    this.enabled,
    this.methodTitle,
    this.methodDescription,
    this.methodSupports,
    this.settings,
    this.needsSetup,
    this.postInstallScripts,
    this.settingsUrl,
    this.connectionUrl,
    this.setupHelpText,
    this.requiredSettingsKeys,
    this.links,
  });

  String? id;
  String? title;
  String? description;
  int? order;
  bool? enabled;
  String? methodTitle;
  String? methodDescription;
  List<String>? methodSupports;
  Settings? settings;
  bool? needsSetup;
  List<dynamic>? postInstallScripts;
  String? settingsUrl;
  dynamic connectionUrl;
  dynamic setupHelpText;
  List<dynamic>? requiredSettingsKeys;
  Links? links;

  factory PaymentMethodsListModel.fromJson(Map<String, dynamic> json) => PaymentMethodsListModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    order: json["order"],
    enabled: json["enabled"],
    methodTitle: json["method_title"],
    methodDescription: json["method_description"],
    methodSupports: List<String>.from(json["method_supports"].map((x) => x)),
    settings: Settings.fromJson(json["settings"]),
    needsSetup: json["needs_setup"],
    postInstallScripts: List<dynamic>.from(json["post_install_scripts"].map((x) => x)),
    settingsUrl: json["settings_url"],
    connectionUrl: json["connection_url"],
    setupHelpText: json["setup_help_text"],
    requiredSettingsKeys: List<dynamic>.from(json["required_settings_keys"].map((x) => x)),
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "order": order,
    "enabled": enabled,
    "method_title": methodTitle,
    "method_description": methodDescription,
    "method_supports": List<dynamic>.from(methodSupports!.map((x) => x)),
    "settings": settings!.toJson(),
    "needs_setup": needsSetup,
    "post_install_scripts": List<dynamic>.from(postInstallScripts!.map((x) => x)),
    "settings_url": settingsUrl,
    "connection_url": connectionUrl,
    "setup_help_text": setupHelpText,
    "required_settings_keys": List<dynamic>.from(requiredSettingsKeys!.map((x) => x)),
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

class Settings {
  Settings({
    this.title,
    this.instructions,
    this.enableForMethods,
    this.enableForVirtual,
  });

  Instructions? title;
  Instructions? instructions;
  Instructions? enableForMethods;
  Instructions? enableForVirtual;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    title: Instructions.fromJson(json["title"]),
    instructions: Instructions.fromJson(json["instructions"]),
    enableForMethods: json["enable_for_methods"] == null ? null : Instructions.fromJson(json["enable_for_methods"]),
    enableForVirtual: json["enable_for_virtual"] == null ? null : Instructions.fromJson(json["enable_for_virtual"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title!.toJson(),
    "instructions": instructions!.toJson(),
    "enable_for_methods": enableForMethods == null ? null : enableForMethods!.toJson(),
    "enable_for_virtual": enableForVirtual == null ? null : enableForVirtual!.toJson(),
  };
}

class Instructions {
  Instructions({
    this.id,
    this.label,
    this.description,
    this.type,
    this.value,
    this.instructionsDefault,
    this.tip,
    this.placeholder,
    this.options,
  });

  String? id;
  String? label;
  String? description;
  String? type;
  String? value;
  String? instructionsDefault;
  String? tip;
  String? placeholder;
  Options? options;

  factory Instructions.fromJson(Map<String, dynamic> json) => Instructions(
    id: json["id"],
    label: json["label"],
    description: json["description"],
    type: json["type"],
    value: json["value"],
    instructionsDefault: json["default"],
    tip: json["tip"],
    placeholder: json["placeholder"],
    options: json["options"] == null ? null : Options.fromJson(json["options"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "description": description,
    "type": type,
    "value": value,
    "default": instructionsDefault,
    "tip": tip,
    "placeholder": placeholder,
    "options": options == null ? null : options!.toJson(),
  };
}

class Options {
  Options({
    this.flatRate,
    this.freeShipping,
    this.localPickup,
  });

  FlatRate? flatRate;
  FreeShipping? freeShipping;
  LocalPickup? localPickup;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
    flatRate: FlatRate.fromJson(json["Flat rate"]),
    freeShipping: FreeShipping.fromJson(json["Free shipping"]),
    localPickup: LocalPickup.fromJson(json["Local pickup"]),
  );

  Map<String, dynamic> toJson() => {
    "Flat rate": flatRate!.toJson(),
    "Free shipping": freeShipping!.toJson(),
    "Local pickup": localPickup!.toJson(),
  };
}

class FlatRate {
  FlatRate({
    this.flatRate,
  });

  String? flatRate;

  factory FlatRate.fromJson(Map<String, dynamic> json) => FlatRate(
    flatRate: json["flat_rate"],
  );

  Map<String, dynamic> toJson() => {
    "flat_rate": flatRate,
  };
}

class FreeShipping {
  FreeShipping({
    this.freeShipping,
  });

  String? freeShipping;

  factory FreeShipping.fromJson(Map<String, dynamic> json) => FreeShipping(
    freeShipping: json["free_shipping"],
  );

  Map<String, dynamic> toJson() => {
    "free_shipping": freeShipping,
  };
}

class LocalPickup {
  LocalPickup({
    this.localPickup,
  });

  String? localPickup;

  factory LocalPickup.fromJson(Map<String, dynamic> json) => LocalPickup(
    localPickup: json["local_pickup"],
  );

  Map<String, dynamic> toJson() => {
    "local_pickup": localPickup,
  };
}
