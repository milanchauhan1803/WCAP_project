import 'dart:io';
import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:flutter/material.dart';

import '../model/customer.dart';

class Customers with ChangeNotifier {
  final client = HttpClient();
  late Customer _item;
  final apiClient = ApiClient();

  Customer get item {
    return _item;
  }

// Loading product

  Future<void> reloadCustomer(String customerId) async {
    _item = await apiClient.getCustomerData(customerId);
    notifyListeners();
  }
}