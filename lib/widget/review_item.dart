import 'package:ecommerce_app/model/reviews_model.dart';
import 'package:ecommerce_app/screen/product/product_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/category.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final review = Provider.of<ReviewsModel>(context, listen: false);
    return Card(
      elevation: 3,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(review.reviewer.toString()),
                onTap: () {
                 /* Navigator.of(context).pushNamed(ProductOverviewScreen.routeName,
                      arguments: review.id);*/
                },
              ),
            ],
          )),
    );
  }
}