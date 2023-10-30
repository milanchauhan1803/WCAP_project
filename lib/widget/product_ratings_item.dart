import 'package:ecommerce_app/widget/product_rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductRatingsItem extends StatefulWidget {
  const ProductRatingsItem({Key? key}) : super(key: key);

  @override
  State<ProductRatingsItem> createState() => _ProductRatingsItemState();
}

class _ProductRatingsItemState extends State<ProductRatingsItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Card(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: ((context, index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset("assets/images/profile_logo.jpg",
                                  width: 50, height: 50),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // showDialog(
                                      // context: context, builder: builder)
                                      _dialogBuilder(context);
                                    },
                                    child: const Text(
                                      "Shomil",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RatingBar.builder(
                                    itemSize: 16,
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemBuilder: (context, int) => const Icon(
                                      Icons.star,
                                      color: Colors.blue,
                                      size: 12,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                          const Text(
                            "05:49 PM",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Nice album!",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Divider(
                        color: Colors.grey,
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return  AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 15,vertical: MediaQuery.of(context).size.height*0.21),
            contentPadding: EdgeInsets.symmetric(horizontal: 0),
            content: ProductRatingWidget(),
          );
        });
  }
}
