import 'dart:convert';

import 'package:flutter/cupertino.dart';
/// id : 20
/// date_created : "2022-09-23T05:49:38"
/// date_created_gmt : "2022-09-23T05:49:38"
/// product_id : 31
/// product_name : "T-Shirt with Logo"
/// product_permalink : "https://wcapi.builderfly.com/product/t-shirt-with-logo/"
/// status : "approved"
/// reviewer : "Shomil"
/// reviewer_email : "shomil.builderfly@gmail.com"
/// review : "<p>Nice album1!</p>\n"
/// rating : 5
/// verified : false
/// reviewer_avatar_urls : {"24":"https://secure.gravatar.com/avatar/a54ed586c590cc244399bab20bd7f5bc?s=24&d=mm&r=g","48":"https://secure.gravatar.com/avatar/a54ed586c590cc244399bab20bd7f5bc?s=48&d=mm&r=g","96":"https://secure.gravatar.com/avatar/a54ed586c590cc244399bab20bd7f5bc?s=96&d=mm&r=g"}
/// _links : {"self":[{"href":"https://wcapi.builderfly.com/wp-json/wc/v3/products/reviews/20"}],"collection":[{"href":"https://wcapi.builderfly.com/wp-json/wc/v3/products/reviews"}],"up":[{"href":"https://wcapi.builderfly.com/wp-json/wc/v3/products/31"}]}

ReviewsModel reviewsModelFromJson(String str) => ReviewsModel.fromJson(json.decode(str));
String reviewsModelToJson(ReviewsModel data) => json.encode(data.toJson());
class ReviewsModel with ChangeNotifier{
  ReviewsModel({
      int? id, 
      String? dateCreated, 
      String? dateCreatedGmt, 
      int? productId, 
      String? productName, 
      String? productPermalink, 
      String? status, 
      String? reviewer, 
      String? reviewerEmail, 
      String? review, 
      int? rating, 
      bool? verified, 
      Links? links,}){
    _id = id;
    _dateCreated = dateCreated;
    _dateCreatedGmt = dateCreatedGmt;
    _productId = productId;
    _productName = productName;
    _productPermalink = productPermalink;
    _status = status;
    _reviewer = reviewer;
    _reviewerEmail = reviewerEmail;
    _review = review;
    _rating = rating;
    _verified = verified;
    _links = links;
}

  ReviewsModel.fromJson(dynamic json) {
    _id = json['id'];
    _dateCreated = json['date_created'];
    _dateCreatedGmt = json['date_created_gmt'];
    _productId = json['product_id'];
    _productName = json['product_name'];
    _productPermalink = json['product_permalink'];
    _status = json['status'];
    _reviewer = json['reviewer'];
    _reviewerEmail = json['reviewer_email'];
    _review = json['review'];
    _rating = json['rating'];
    _verified = json['verified'];
  }
  int? _id;
  String? _dateCreated;
  String? _dateCreatedGmt;
  int? _productId;
  String? _productName;
  String? _productPermalink;
  String? _status;
  String? _reviewer;
  String? _reviewerEmail;
  String? _review;
  int? _rating;
  bool? _verified;
  Links? _links;

  int? get id => _id;
  String? get dateCreated => _dateCreated;
  String? get dateCreatedGmt => _dateCreatedGmt;
  int? get productId => _productId;
  String? get productName => _productName;
  String? get productPermalink => _productPermalink;
  String? get status => _status;
  String? get reviewer => _reviewer;
  String? get reviewerEmail => _reviewerEmail;
  String? get review => _review;
  int? get rating => _rating;
  bool? get verified => _verified;
  Links? get links => _links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date_created'] = _dateCreated;
    map['date_created_gmt'] = _dateCreatedGmt;
    map['product_id'] = _productId;
    map['product_name'] = _productName;
    map['product_permalink'] = _productPermalink;
    map['status'] = _status;
    map['reviewer'] = _reviewer;
    map['reviewer_email'] = _reviewerEmail;
    map['review'] = _review;
    map['rating'] = _rating;
    map['verified'] = _verified;
    if (_links != null) {
      map['_links'] = _links?.toJson();
    }
    return map;
  }

}

/// self : [{"href":"https://wcapi.builderfly.com/wp-json/wc/v3/products/reviews/20"}]
/// collection : [{"href":"https://wcapi.builderfly.com/wp-json/wc/v3/products/reviews"}]
/// up : [{"href":"https://wcapi.builderfly.com/wp-json/wc/v3/products/31"}]

String linksToJson(Links data) => json.encode(data.toJson());
class Links {
  Links({
      List<Self>? self, 
      List<Collection>? collection, 
      List<Up>? up,}){
    _self = self;
    _collection = collection;
    _up = up;
}


  List<Self>? _self;
  List<Collection>? _collection;
  List<Up>? _up;

  List<Self>? get self => _self;
  List<Collection>? get collection => _collection;
  List<Up>? get up => _up;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_self != null) {
      map['self'] = _self?.map((v) => v.toJson()).toList();
    }
    if (_collection != null) {
      map['collection'] = _collection?.map((v) => v.toJson()).toList();
    }
    if (_up != null) {
      map['up'] = _up?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// href : "https://wcapi.builderfly.com/wp-json/wc/v3/products/31"

Up upFromJson(String str) => Up.fromJson(json.decode(str));
String upToJson(Up data) => json.encode(data.toJson());
class Up {
  Up({
      String? href,}){
    _href = href;
}

  Up.fromJson(dynamic json) {
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

/// href : "https://wcapi.builderfly.com/wp-json/wc/v3/products/reviews"

Collection collectionFromJson(String str) => Collection.fromJson(json.decode(str));
String collectionToJson(Collection data) => json.encode(data.toJson());
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

/// href : "https://wcapi.builderfly.com/wp-json/wc/v3/products/reviews/20"

Self selfFromJson(String str) => Self.fromJson(json.decode(str));
String selfToJson(Self data) => json.encode(data.toJson());
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

/// 24 : "https://secure.gravatar.com/avatar/a54ed586c590cc244399bab20bd7f5bc?s=24&d=mm&r=g"
/// 48 : "https://secure.gravatar.com/avatar/a54ed586c590cc244399bab20bd7f5bc?s=48&d=mm&r=g"
/// 96 : "https://secure.gravatar.com/avatar/a54ed586c590cc244399bab20bd7f5bc?s=96&d=mm&r=g"


