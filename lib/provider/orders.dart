import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:ecommerce_app/model/order.dart';

class Orders with ChangeNotifier {
  final apiClient = ApiClient();
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  // Loading Order

  Future<void> getOrders(String customerId) async {
    _orders = await apiClient.getOrder(customerId);
    notifyListeners();
  }
}
