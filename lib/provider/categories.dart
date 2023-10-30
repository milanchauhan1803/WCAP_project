import 'dart:io';
import 'package:ecommerce_app/model/category.dart';
import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:flutter/material.dart';

class Categories with ChangeNotifier {
  final client = HttpClient();
  List<Category> _items = [];
  final apiClient = ApiClient();

  List<Category> get items {
    return [..._items];
  }

// Loading product

  Future<void> reloadCategory() async {
    _items = await apiClient.getCategory();
    notifyListeners();
  }

// id

  Category findById(int id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

}