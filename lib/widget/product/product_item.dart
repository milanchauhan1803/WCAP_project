import 'dart:convert';

import 'package:ecommerce_app/model/cart_list_model.dart';
import 'package:ecommerce_app/screen/product/product_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/provider/cart.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/screen/product/product_detail_screen.dart';
import '../../model/LoginModel.dart';
import '../../utilities/app_constants.dart';
import '../../utilities/common_utilities.dart';
import '../../utilities/preference_utils.dart';
import '../../utilities/product_details_arguments.dart';

class ProductItem extends StatefulWidget {
  List<Product> products;
  String previousScreen;

  ProductItem(this.products, this.previousScreen, {Key? key}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late Data userData;
  var uname,password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              List<Product> relatedProducts = [];
              for (int relatedId in product.relatedIds!) {
                for (Product getProduct in widget.products) {
                  if (relatedId == getProduct.id) {
                    relatedProducts.add(getProduct);
                  }
                }
              }

              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                  arguments:
                      ProductDetailsArguments(relatedProducts, product.id!));
            },
            child: Column(
              children: [
                product.images != null && product.images!.isNotEmpty
                    ? Image(
                        height: 100,
                        image: NetworkImage(product.images![0].src.toString()))
                    : const Image(
                        height: 100,
                        image: AssetImage("assets/images/loading.png")),
                const SizedBox(height: 8),
                Text(product.name.toString(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                const SizedBox(height: 8),
                product.price != null && product.price != ""
                    ? Text(
                        '${product.price.toString()} ${''} ${AppConstants.currencySymbol}',
                        textAlign: TextAlign.center)
                    : const Text(' ', textAlign: TextAlign.center),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Consumer<Product>(
              //   builder: (context, product, _) => IconButton(
              //     icon: Icon(Icons.favorite_border/*product.isFavorite
              //         ? Icons.favorite
              //         : Icons.favorite_border*/),
              //     color: Theme.of(context).colorScheme.secondary,
              //     onPressed: () {
              //       //product.toggleFavoriteStatus();
              //     },
              //   ),
              // ),
              isLoading ? Container(margin: const EdgeInsets.all(12), child: const SizedBox(width:23,height:23,child: CircularProgressIndicator()),)
                  : widget.previousScreen == (ProductOverviewScreen).toString() ? IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  addToCart(product,cart);
                },
              )
                  : Container()
            ],
          )
        ],
      ),
    );
  }

  addToCart(Product product, Cart cart) async {
    var addtocart;

    if (product.type == AppConstants.grouped) {
      var obj = {};
      for (var i = 0; i < product.groupedProducts!.length; i++) {
        obj[product.groupedProducts!.elementAt(i).toString()] = 1;
      }
      print("CartGroup:--"+obj.toString());
      addtocart = await cart.addItem(
          product.id.toString(),
          "1",obj,false
      );
    }
    else if(product.type == AppConstants.variable){
      addtocart = await cart.addItem(
          product.id.toString(),
          "1",{},true
      );
    }
    else{
      addtocart = await cart.addItem(
          product.id.toString(),
          "1",{},false
      );
      print("objectAddtocart:--"+addtocart.toString());
    }

    if (addtocart != null && addtocart.notices.success.isNotEmpty) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Added to cart',
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }
}
