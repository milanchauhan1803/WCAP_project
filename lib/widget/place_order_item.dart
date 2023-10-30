import 'dart:math';
import 'package:ecommerce_app/utilities/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/cart_list_model.dart';

class PlaceOrderItemWidget extends StatefulWidget {
  final CartListModel order;
  final String total;
  const PlaceOrderItemWidget({Key? key, required this.order, required this.total}) : super(key: key);

  @override
  State<PlaceOrderItemWidget> createState() => _PlaceOrderItemWidgetState();
}

class _PlaceOrderItemWidgetState extends State<PlaceOrderItemWidget> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          ListTile(
            title: Text('${double.parse(widget.total)/100} ${''} ${AppConstants.currencySymbol}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(DateTime.now()),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: ListView.builder(
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              padding: const EdgeInsets.only(bottom: 10,right: 15,left: 15),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.order.items!.length,
              itemBuilder: (context, i) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.order.items!.elementAt(i).title.toString(),
                    // maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.order.items!.elementAt(i).quantity!.value.toString()}x ${double.parse(widget.order.items!.elementAt(i).price.toString())/100} ${''} ${AppConstants.currencySymbol}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            secondChild: Container(),
            crossFadeState: _expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),
          /*if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: min(widget.order.items!.length * 20.0 + 10, 100),
              child: ListView(
                children: widget.order.items!
                    .map(
                      (prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            prod.title.toString(),
                            // maxLines: 2,
                            style: const TextStyle(
                              fontSize: 13,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${prod.quantity!.value.toString()}x ${prod.price} ₸',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),*/
        ],
      ),
    );
  }
}
