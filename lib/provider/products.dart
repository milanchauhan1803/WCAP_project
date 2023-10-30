import 'dart:io';

import 'package:ecommerce_app/utilities/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:ecommerce_app/model/product.dart';

import '../utilities/common_utilities.dart';

class Products with ChangeNotifier {
  final client = HttpClient();
  List<Product> _items = [];
  final apiClient = ApiClient();
  List<Product> _allResult = [];

  var _showFavoritesOnly = false;

  List<Product> get items {
    return [..._items];
  }

  // Loading product
  Future<void> reloadProduct() async {
    _items.clear();
    _allResult.clear();
    _items = await apiClient.getProduct();
    _allResult.addAll(_items);
    notifyListeners();
  }

  //Category reload product
  Future<void> reloadCategoryProduct(int categoryId) async {
    _items.clear();
    _allResult.clear();
    _items = await apiClient.getCategoryProduct(categoryId);
    _allResult.addAll(_items);
    notifyListeners();
  }

  //Select product list
  Future<dynamic> searchProduct(dynamic searchValue) async {
    _items.clear();
    if(searchValue != ""){
      for (var userDetail in _allResult) {
        if (userDetail.name!.toLowerCase().contains(searchValue.toString().toLowerCase())){
          _items.add(userDetail);
        }
      }
    }else{
      _items.addAll(_allResult);
    }

    notifyListeners();
  }

  //sort product list
  Future<dynamic> sortProduct(dynamic sortValue) async {
    _items.clear();
    if(sortValue != ""){
      _allResult.sort((a, b) => b.totalSales!.compareTo(a.totalSales!));
      CommonUtilities.printMsg("Coupon_items:--" + _allResult.reversed.toString());
      _items.addAll(_allResult);
    }else{
      _items.addAll(_allResult);
    }

    notifyListeners();
  }

  //Select product list
  Future<dynamic> filterProduct(dynamic sortValue,bool onSale,bool featured,int min,int max) async {
    _items.clear();
    _items.addAll(_allResult);

    if(sortValue != ""){
      if(sortValue == AppConstants.popularity){
        _allResult.sort((a, b) => b.totalSales!.compareTo(a.totalSales!));
        CommonUtilities.printMsg("Coupon_items:--" + _allResult.reversed.toString());
        _items.clear();
        _items.addAll(_allResult.reversed);
      }
      else if(sortValue == AppConstants.dateAdded){
        _allResult.sort((a, b) => DateTime.parse(b.dateCreated!.toString()).compareTo(DateTime.parse(a.dateCreated!.toString())));
        CommonUtilities.printMsg("Coupon_items:--" + _allResult.toString());
        _items.clear();
        _items.addAll(_allResult);
      }
      else if(sortValue == AppConstants.priceLowestFirst){
        _allResult.sort((a, b) => int.parse(b.price!).compareTo(int.parse(a.price!)));
        CommonUtilities.printMsg("Coupon_items:--" + _allResult.reversed.toString());
        _items.clear();
        _items.addAll(_allResult.reversed);
      }
      else if(sortValue == AppConstants.priceHighestFirst){
        _allResult.sort((a, b) => int.parse(b.price!).compareTo(int.parse(a.price!)));
        CommonUtilities.printMsg("Coupon_items:--" + _allResult.reversed.toString());
        _items.clear();
        _items.addAll(_allResult);
      }

    }

    if(min != 0){
      _items = _items.where(
              (element) => double.parse(element.price!.toString()) >= double.parse(min.toString())
      ).toList();
    }

    if(max != 0){
      _items = _items.where((element) => double.parse(element.price!.toString()) <= double.parse(max.toString())).toList();
    }

    if(onSale){
      _items = _items.where((element) => element.onSale! == true).toList();
    }

    if(featured){
      _items = _items.where((element) => element.featured! == true).toList();
    }

    //_items.addAll(_allResult);
    CommonUtilities.printMsg("_allResult:--"+_items.toString());
    notifyListeners();
  }

// Filter: favorite items

  /*List<Product> get favoriteItem {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }*/

// id

  Product findById(int id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void showFavoritesOnly() {
    _showFavoritesOnly = false;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }
}
