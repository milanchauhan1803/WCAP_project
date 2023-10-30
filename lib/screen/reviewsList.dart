import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:ecommerce_app/provider/categories.dart';
import 'package:ecommerce_app/provider/reviews.dart';
import 'package:ecommerce_app/widget/category_item.dart';
import 'package:ecommerce_app/widget/review_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewsList extends StatefulWidget {
  static const routeName = '/reviews';

  const ReviewsList({Key? key}) : super(key: key);

  @override
  State<ReviewsList> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<ReviewsList> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      addReviewProduct(31, "review", "reviewer", 'email@gmail.com', 5);

      Provider.of<Reviews>(context).loadingReviews().then(
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
    final reviews = Provider.of<Reviews>(context);
    final reviewsList = reviews.items;
    return Scaffold(
        appBar: AppBar(
          title: Text('Reviews'),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: ListView.builder(
                  itemCount: reviewsList.length,
                  itemBuilder: (context, i) => ChangeNotifierProvider.value(
                    value: reviewsList[i],
                    child: const ReviewItem(),
                  ),
                ),
              ));
  }
  Future<void> addReviewProduct(int product_id, String review,String reviewer,String email,double rating) async {
    final apiClient = ApiClient();
    final addReviewModel =
    await apiClient.addProductReview(product_id: product_id, review: review,reviewer: reviewer,reviewer_email: email,rating: rating);
    print("loginresponse:---"+addReviewModel.reviewer.toString());
  }
}
