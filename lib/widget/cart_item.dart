import 'package:ecommerce_app/model/cart_list_model.dart';
import 'package:ecommerce_app/utilities/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/provider/cart.dart';

class CartItemOrder extends StatelessWidget {
  /*final int id;
  final double price;
  final String productId;
  final int quantity;
  final String title;*/
  const CartItemOrder({
    Key? key/*,
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
    required this.productId,*/
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Item>(context, listen: false);

    return Dismissible(
      key: ValueKey(cart.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Would you like to confirm?',
            ),
            content: const Text('Do you want to remove from the cart?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(cart.itemKey.toString(),cart);
      },
      child: Column(
        children: [
          Column(
            children: [
              Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ListTile(
                    leading: cart.featuredImage != null && cart.featuredImage != "" ? CircleAvatar(
                      //radius: 20,
                      backgroundImage: NetworkImage(cart.featuredImage.toString()),
                     /* child: Image(image: NetworkImage(cart.featuredImage.toString())),*/
                    )
                        : const CircleAvatar(
                      //radius: 20,
                      backgroundImage: AssetImage("assets/images/loading.png"),
                      /* child: Image(image: NetworkImage(cart.featuredImage.toString())),*/
                    ),
                    title: Text(cart.title.toString()),
                    subtitle: Text('Total: ${cart.totals!.total.toString()} ${''} ${AppConstants.currencySymbol}'),
                    trailing: Text('${cart.quantity!.value.toString()} x'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
