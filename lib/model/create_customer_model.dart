/// id : 25
/// date_created : "2017-03-21T16:09:28"
/// date_created_gmt : "2017-03-21T19:09:28"
/// date_modified : "2017-03-21T16:09:30"
/// date_modified_gmt : "2017-03-21T19:09:30"
/// email : "john.doe@example.com"
/// first_name : "John"
/// last_name : "Doe"
/// role : "customer"
/// username : "john.doe"
/// billing : {"first_name":"John","last_name":"Doe","company":"","address_1":"969 Market","address_2":"","city":"San Francisco","state":"CA","postcode":"94103","country":"US","email":"john.doe@example.com","phone":"(555) 555-5555"}
/// shipping : {"first_name":"John","last_name":"Doe","company":"","address_1":"969 Market","address_2":"","city":"San Francisco","state":"CA","postcode":"94103","country":"US"}
/// is_paying_customer : false
/// avatar_url : "https://secure.gravatar.com/avatar/8eb1b522f60d11fa897de1dc6351b7e8?s=96"
/// meta_data : []
/// _links : {"self":[{"href":"https://example.com/wp-json/wc/v3/customers/25"}],"collection":[{"href":"https://example.com/wp-json/wc/v3/customers"}]}

class CreateCustomerModel {
  CreateCustomerModel({
      int? id, 
      String? dateCreated, 
      String? dateCreatedGmt, 
      String? dateModified, 
      String? dateModifiedGmt, 
      String? email, 
      String? firstName, 
      String? lastName, 
      String? role, 
      String? username, 
      Billing? billing, 
      Shipping? shipping, 
      bool? isPayingCustomer, 
      String? avatarUrl, 
      List<dynamic>? metaData, 
      Links? links,}){
    _id = id;
    _dateCreated = dateCreated;
    _dateCreatedGmt = dateCreatedGmt;
    _dateModified = dateModified;
    _dateModifiedGmt = dateModifiedGmt;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _role = role;
    _username = username;
    _billing = billing;
    _shipping = shipping;
    _isPayingCustomer = isPayingCustomer;
    _avatarUrl = avatarUrl;
    _metaData = metaData;
    _links = links;
}

  CreateCustomerModel.fromJson(dynamic json) {
    _id = json['id'];
    _dateCreated = json['date_created'];
    _dateCreatedGmt = json['date_created_gmt'];
    _dateModified = json['date_modified'];
    _dateModifiedGmt = json['date_modified_gmt'];
    _email = json['email'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _role = json['role'];
    _username = json['username'];
    _billing = json['billing'] != null ? Billing.fromJson(json['billing']) : null;
    _shipping = json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;
    _isPayingCustomer = json['is_paying_customer'];
    _avatarUrl = json['avatar_url'];
    if (json['meta_data'] != null) {
      _metaData = [];

    }
    _links = json['_links'] != null ? Links.fromJson(json['Links']) : null;
  }
  int? _id;
  String? _dateCreated;
  String? _dateCreatedGmt;
  String? _dateModified;
  String? _dateModifiedGmt;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _role;
  String? _username;
  Billing? _billing;
  Shipping? _shipping;
  bool? _isPayingCustomer;
  String? _avatarUrl;
  List<dynamic>? _metaData;
  Links? _links;

  int? get id => _id;
  String? get dateCreated => _dateCreated;
  String? get dateCreatedGmt => _dateCreatedGmt;
  String? get dateModified => _dateModified;
  String? get dateModifiedGmt => _dateModifiedGmt;
  String? get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get role => _role;
  String? get username => _username;
  Billing? get billing => _billing;
  Shipping? get shipping => _shipping;
  bool? get isPayingCustomer => _isPayingCustomer;
  String? get avatarUrl => _avatarUrl;
  List<dynamic>? get metaData => _metaData;
  Links? get links => _links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date_created'] = _dateCreated;
    map['date_created_gmt'] = _dateCreatedGmt;
    map['date_modified'] = _dateModified;
    map['date_modified_gmt'] = _dateModifiedGmt;
    map['email'] = _email;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['role'] = _role;
    map['username'] = _username;
    if (_billing != null) {
      map['billing'] = _billing?.toJson();
    }
    if (_shipping != null) {
      map['shipping'] = _shipping?.toJson();
    }
    map['is_paying_customer'] = _isPayingCustomer;
    map['avatar_url'] = _avatarUrl;
    if (_metaData != null) {
      map['meta_data'] = _metaData?.map((v) => v.toJson()).toList();
    }
    if (_links != null) {
      map['_links'] = _links?.toJson();
    }
    return map;
  }

}

/// self : [{"href":"https://example.com/wp-json/wc/v3/customers/25"}]
/// collection : [{"href":"https://example.com/wp-json/wc/v3/customers"}]

class Links {
  Links({
      List<Self>? self, 
      List<Collection>? collection,}){
    _self = self;
    _collection = collection;
}

  Links.fromJson(dynamic json) {
    if(json != null) {
      if (json['self'] != null) {
        _self = [];
        json['self'].forEach((v) {
          _self?.add(Self.fromJson(v));
        });
      }
      if (json['collection'] != null) {
        _collection = [];
        json['collection'].forEach((v) {
          _collection?.add(Collection.fromJson(v));
        });
      }
    }
  }
  List<Self>? _self;
  List<Collection>? _collection;

  List<Self>? get self => _self;
  List<Collection>? get collection => _collection;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_self != null) {
      map['self'] = _self?.map((v) => v.toJson()).toList();
    }
    if (_collection != null) {
      map['collection'] = _collection?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// href : "https://example.com/wp-json/wc/v3/customers"

class Collection {
  Collection({
      String? href,}){
    _href = href;
}

  Collection.fromJson(dynamic json) {
    _href = json['href'];
  }
  String? _href;

  String? get href => _href;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['href'] = _href;
    return map;
  }

}

/// href : "https://example.com/wp-json/wc/v3/customers/25"

class Self {
  Self({
      String? href,}){
    _href = href;
}

  Self.fromJson(dynamic json) {
    _href = json['href'];
  }
  String? _href;

  String? get href => _href;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['href'] = _href;
    return map;
  }

}

/// first_name : "John"
/// last_name : "Doe"
/// company : ""
/// address_1 : "969 Market"
/// address_2 : ""
/// city : "San Francisco"
/// state : "CA"
/// postcode : "94103"
/// country : "US"

class Shipping {
  Shipping({
      String? firstName, 
      String? lastName, 
      String? company, 
      String? address1, 
      String? address2, 
      String? city, 
      String? state, 
      String? postcode, 
      String? country,}){
    _firstName = firstName;
    _lastName = lastName;
    _company = company;
    _address1 = address1;
    _address2 = address2;
    _city = city;
    _state = state;
    _postcode = postcode;
    _country = country;
}

  Shipping.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _company = json['company'];
    _address1 = json['address_1'];
    _address2 = json['address_2'];
    _city = json['city'];
    _state = json['state'];
    _postcode = json['postcode'];
    _country = json['country'];
  }
  String? _firstName;
  String? _lastName;
  String? _company;
  String? _address1;
  String? _address2;
  String? _city;
  String? _state;
  String? _postcode;
  String? _country;

  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get company => _company;
  String? get address1 => _address1;
  String? get address2 => _address2;
  String? get city => _city;
  String? get state => _state;
  String? get postcode => _postcode;
  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['company'] = _company;
    map['address_1'] = _address1;
    map['address_2'] = _address2;
    map['city'] = _city;
    map['state'] = _state;
    map['postcode'] = _postcode;
    map['country'] = _country;
    return map;
  }

}

/// first_name : "John"
/// last_name : "Doe"
/// company : ""
/// address_1 : "969 Market"
/// address_2 : ""
/// city : "San Francisco"
/// state : "CA"
/// postcode : "94103"
/// country : "US"
/// email : "john.doe@example.com"
/// phone : "(555) 555-5555"

class Billing {
  Billing({
      String? firstName, 
      String? lastName, 
      String? company, 
      String? address1, 
      String? address2, 
      String? city, 
      String? state, 
      String? postcode, 
      String? country, 
      String? email, 
      String? phone,}){
    _firstName = firstName;
    _lastName = lastName;
    _company = company;
    _address1 = address1;
    _address2 = address2;
    _city = city;
    _state = state;
    _postcode = postcode;
    _country = country;
    _email = email;
    _phone = phone;
}

  Billing.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _company = json['company'];
    _address1 = json['address_1'];
    _address2 = json['address_2'];
    _city = json['city'];
    _state = json['state'];
    _postcode = json['postcode'];
    _country = json['country'];
    _email = json['email'];
    _phone = json['phone'];
  }
  String? _firstName;
  String? _lastName;
  String? _company;
  String? _address1;
  String? _address2;
  String? _city;
  String? _state;
  String? _postcode;
  String? _country;
  String? _email;
  String? _phone;

  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get company => _company;
  String? get address1 => _address1;
  String? get address2 => _address2;
  String? get city => _city;
  String? get state => _state;
  String? get postcode => _postcode;
  String? get country => _country;
  String? get email => _email;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['company'] = _company;
    map['address_1'] = _address1;
    map['address_2'] = _address2;
    map['city'] = _city;
    map['state'] = _state;
    map['postcode'] = _postcode;
    map['country'] = _country;
    map['email'] = _email;
    map['phone'] = _phone;
    return map;
  }

}