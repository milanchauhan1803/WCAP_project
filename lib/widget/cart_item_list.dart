import 'package:ecommerce_app/provider/cart.dart';
import 'package:ecommerce_app/utilities/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/provider/products.dart';
import 'package:ecommerce_app/widget/product/product_item.dart';

import '../model/cart_list_model.dart';
import '../screen/place_order.dart';
import 'cart_item.dart';

class CartItemList extends StatelessWidget {
  //final bool showFavs;

  const CartItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    //final productsData = Provider.of<Products>(context);
    //final products = showFavs ? productsData.favoriteItem : productsData.items;
    final products = cart.items;

    return Scaffold(
      /*appBar: AppBar(
        title: const Text('Basket '),
      ),*/
      body: cart.items.isNotEmpty/* && cart.itemCountCart != "0" */? Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(//this is temporary /100
                    label: Text(
                      '${int.parse(cart.totalAmout.toString())/100} ${''} ${AppConstants.currencySymbol}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  /*TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => CheckoutScreen(cartListModel: cart.responseCart,),
                        ),
                      );
                       *//*Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.toList(),
                          cart.itemCount,
                          cart.totalAmout,
                        );*//*
                        //cart.clear();
                    },
                    child: const Text('Order'),
                  ),*/
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, i) => ChangeNotifierProvider.value(
                value: products[i],
                child: const CartItemOrder(),
              ),
              /*itemBuilder: (context, i) => CartItemOrder(
                  id: 1,
                  title: "cart.items.values.toList()[i].title",
                  quantity: 1,
                  price: 10.00,
                  productId: "1",
                ),*/
            ),
          ),
          cart.itemCountCart != "0" ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: TextButton(
            style: TextButton.styleFrom(
                padding: const EdgeInsets.all(10.0),
                primary: Colors.white,
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity,45),
                textStyle: const TextStyle(fontSize: 16.0)
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => PlaceOrderScreen(cartListModel: cart.responseCart,),
                ),
              );
            },
            child: const Text("Proceed to Checkout"),
          ),)
              : Container()
        ],
      )
          : const Center(child: Text(
          'Cart is empty',
          style: TextStyle(fontSize: 20,color: Colors.grey),
        ),),
    );
  }
}