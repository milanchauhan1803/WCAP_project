import 'dart:io';
import 'package:ecommerce_app/model/payment_methods_list_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/ApiClient/api_client.dart';

class PaymentMethodsList with ChangeNotifier {
  final client = HttpClient();
  List<PaymentMethodsListModel> _items = [];
  final apiClient = ApiClient();

  List<PaymentMethodsListModel> get items {
    return [..._items];
  }

  // Loading methods
  Future<void> reloadPaymentMethods() async {
    final items = await apiClient.getPaymentMethodsList();
    _items.clear();
    _items += items;
    notifyListeners();
  }

  PaymentMethodsListModel findById(int id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

}
