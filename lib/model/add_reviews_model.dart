import 'dart:convert';
/// id : 21
/// date_created : "2022-09-23T09:45:59"
/// date_created_gmt : "2022-09-23T09:45:59"
/// product_id : 31
/// product_name : "T-Shirt with Logo"
/// product_permalink : "https://wcapi.builderfly.com/product/t-shirt-with-logo/"
/// status : "approved"
/// reviewer : "Shomil"
/// reviewer_email : "shomil.builderfly@gmail.com"
/// review : "Nice album12!"
/// rating : 5
/// verified : false

AddReviewsModel addReviewsModelFromJson(String str) => AddReviewsModel.fromJson(json.decode(str));
String addReviewsModelToJson(AddReviewsModel data) => json.encode(data.toJson());
class AddReviewsModel {
  AddReviewsModel({
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
      bool? verified,}){
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
}

  AddReviewsModel.fromJson(dynamic json) {
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
    return map;
  }

}