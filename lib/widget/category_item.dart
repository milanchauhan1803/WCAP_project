import 'package:ecommerce_app/screen/product/product_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/category.dart';
import '../utilities/arguments.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<Category>(context, listen: false);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Card(
        elevation: 3,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(category.name),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ProductOverviewScreen.routeName,
                      arguments: ArgumentTwo(category.id, category.name),
                    );
                  },
                ),
              ],
            )),
      ),
    );
  }
}
