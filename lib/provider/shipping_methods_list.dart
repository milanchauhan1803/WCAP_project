import 'dart:io';
import 'package:ecommerce_app/model/shipping_methods_list_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/ApiClient/api_client.dart';

class ShippingMethodsList with ChangeNotifier {
  final client = HttpClient();
  List<ShippingMethodsListModel> _items = [];
  final apiClient = ApiClient();

  List<ShippingMethodsListModel> get items {
    return [..._items];
  }

  // Loading methods
  Future<void> reloadShippingMethods() async {
    final items = await apiClient.getShippingMethodsList();
    _items.clear();
    _items += items;
    notifyListeners();
  }

  ShippingMethodsListModel findById(int id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

}
