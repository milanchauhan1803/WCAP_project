import 'package:ecommerce_app/model/coupon.dart';
import 'package:flutter/material.dart';
import '../ApiClient/api_client.dart';

class Coupons with ChangeNotifier {
  final apiClient = ApiClient();
  List<Coupon> _coupons = [];

  List<Coupon> get coupons {
    return [..._coupons];
  }

  // Loading Order

  Future<void> getCoupons() async {
    _coupons = await apiClient.getCoupons();
    notifyListeners();
  }
}