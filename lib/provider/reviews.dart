import 'dart:io';
import 'package:ecommerce_app/model/category.dart';
import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:ecommerce_app/model/reviews_model.dart';
import 'package:flutter/material.dart';

class Reviews with ChangeNotifier {
  final client = HttpClient();
  List<ReviewsModel> _items = [];
  final apiClient = ApiClient();

  List<ReviewsModel> get items {
    return [..._items];
  }

// Loading product

  Future<void> loadingReviews() async {
    _items = await apiClient.getReviews();
    notifyListeners();
  }

// id

  ReviewsModel findById(int id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}