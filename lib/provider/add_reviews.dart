import 'dart:io';
import 'package:ecommerce_app/model/add_reviews_model.dart';
import 'package:ecommerce_app/model/category.dart';
import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:ecommerce_app/model/reviews_model.dart';
import 'package:flutter/material.dart';

class AddReviews with ChangeNotifier {
  final client = HttpClient();
  late AddReviewsModel _items;

  final apiClient = ApiClient();

  AddReviewsModel get items {
    return _items;
  }

// Loading product

  Future<void> addReviews(int product_id, String review, String reviewer,
      String reviewer_email, double rating) async {
    _items = await apiClient.addProductReview(
        product_id: product_id,
        rating: rating,
        review: review,
        reviewer_email: reviewer_email,
        reviewer: reviewer);
    notifyListeners();
  }

// id

}
