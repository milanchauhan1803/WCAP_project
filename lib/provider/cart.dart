import 'package:ecommerce_app/model/cart_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../ApiClient/api_client.dart';

class CartItem {
  final int id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  final apiClient = ApiClient();
  List<Item> _items = [];
  var total = "0.0";
  late CartListModel cartListModelData;

  var itemCountCart = "0";

  List<Item> get items {
    return [..._items];
  }

  Future<void> getCartList() async {
    final items = await apiClient.getItemsCart();
    //final products = CartListModel.fromJson(items);
    print("items1:--"+items.toString());
    print("items1:--"+items.items!.length.toString());
    cartListModelData = items;
    total = items.totals!.total.toString();
    _items.clear();
    _items += items.items!;
    itemCountCart = _items.length.toString();
    notifyListeners();
  }

  Future<void> clearCartList() async {
    final items = await apiClient.clearCart();
    //final products = CartListModel.fromJson(items);
    print("items1:--"+items.toString());
    print("items1:--"+items.items!.length.toString());
    _items.clear();
    total = items.totals!.total.toString();
    itemCountCart = "0";
    notifyListeners();
  }

  dynamic get responseCart {
    return cartListModelData;
  }

  dynamic get itemCount {
    return itemCountCart;
  }

  dynamic get totalAmout {
    //total = 0.0;
    /*_items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });*/
    return total;
  }

  Future<dynamic> addItem(
      String productId,
      String qty,Map<dynamic, dynamic> qtyGrouped,bool isVariable
      ) async {
    final orders = await apiClient.addToCart(
        productId,qty,qtyGrouped,isVariable
    );

    if(orders != null){
      print("AddtoCartRes:--"+orders.toString());
      itemCountCart = orders.items.length.toString();
      notifyListeners();
      return orders;
    }else{
      return null;
    }

  }

  Future<void> removeItem(String itemKey,Item item) async {
    final removeItem = await apiClient.deleteItemFromCart(itemKey);
    print("removeItem:--"+removeItem.toString());
    _items.remove(item);
    itemCountCart = removeItem.items.length.toString();
    total = removeItem.totals!.total.toString();

    notifyListeners();
  }

/*void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (exCartItem) => CartItem(
          id: exCartItem.id,
          title: exCartItem.title,
          quantity: exCartItem.quantity - 1,
          price: exCartItem.price,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }*/

/*void clear() {
    _items = {};
    notifyListeners();
  }*/
}