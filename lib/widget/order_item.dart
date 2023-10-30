import 'package:ecommerce_app/model/order.dart';
import 'package:ecommerce_app/provider/orders.dart';
import 'package:ecommerce_app/screen/order_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatelessWidget {
  final Order _order;
  OrderItem(this._order,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat("dd-MM-yyyy"); // you can change the format here
    var utcDate = dateFormat.format(DateTime.parse(_order.createdDate)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _order.status == "completed" ? Row(
                children: [
                  Image.asset(
                    "assets/images/order_completed.jpeg",
                    scale: 13,
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    _order.status,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ) :
              Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    color: Colors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    _order.status,
                    style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.grey.shade500,
                height: 0,
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order ID",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "#" + _order.id.toString(),
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Order Date",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        createdDate,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(OrderDetailsScreen.routeName, arguments: _order);
                  },
                  child: const Text(
                    "Order Details",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );;
  }
}