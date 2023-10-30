import 'package:ecommerce_app/widget/cart_item_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/screen/place_order.dart';
import 'package:ecommerce_app/widget/cart_item.dart';

import '../ApiClient/api_client.dart';
import '../model/cart_list_model.dart';
import '../provider/cart.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  const CartScreen({Key? key}) : super(key: key);


  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;
  final apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
  }

// Загрузка товаров

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Cart>(context).getCartList().then(
            (_) {
          setState(() {
            _isLoading = false;
          });
        },
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //final cart = Provider.of<CartListModel>(context);
    //final productsData = Provider.of<Products>(context);
    //final products = showFavs ? productsData.favoriteItem : productsData.items;
    //final products = cart.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket '),
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator(),)
          : const CartItemList(),
    );
  }
}
