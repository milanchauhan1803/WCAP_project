import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:ecommerce_app/model/reviews_model.dart';
import 'package:ecommerce_app/provider/categories.dart';
import 'package:ecommerce_app/provider/reviews.dart';
import 'package:ecommerce_app/widget/category_item.dart';
import 'package:ecommerce_app/widget/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widget/product_rating_widget.dart';

class ReviewsList extends StatefulWidget {
  static const routeName = '/reviews';
  final productId;

  const ReviewsList({
    Key? key,
    this.productId,
  }) : super(key: key);

  @override
  State<ReviewsList> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<ReviewsList>
    with WidgetsBindingObserver {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      didChangeDependencies();
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

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

    Iterable<List> filteredReviewsList = reviewsList
        .where((item) => item.productId == widget.productId)
        .cast<List>();
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Card(
            margin: const EdgeInsets.all(0),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: filteredReviewsList.length,
              itemBuilder: (context, i) => ChangeNotifierProvider.value(
                value: reviewsList[i],
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        reviewsList[i].reviewer.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RatingBar.builder(
                                        itemSize: 16,
                                        initialRating:
                                            reviewsList[i].rating!.toDouble(),
                                        minRating: 0,
                                        ignoreGestures: true,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemBuilder: (context, int) =>
                                            const Icon(
                                          Icons.star,
                                          color: Colors.blue,
                                          size: 12,
                                        ),
                                        onRatingUpdate: (double value) {
                                          value =
                                              reviewsList[i].rating!.toDouble();
                                          print(value);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                DateFormat("MMM dd, yyyy").format(
                                    DateTime.parse(
                                        reviewsList[i].dateCreated.toString())),
                                // DateFormat("dd-MM-yyyy").format(DateTime(
                                //     int.parse())),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Html(
                            data: reviewsList[i].review.toString(),
                            style: {
                              "body": Style(
                                  fontSize: const FontSize(16.0),
                                  color: Colors.grey),
                            },
                          ),

                          /* Text(
                            reviewsList[i].review.toString(),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 16),
                          ),*/
                          /* const SizedBox(
                            height: 50,
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(color: Colors.grey);
              },
            ),
          );
  }

  Future<void> addReviewProduct(int productId, String review, String reviewer,
      String email, double rating) async {
    final apiClient = ApiClient();
    final addReviewModel = await apiClient.addProductReview(
      product_id: productId,
      review: review,
      reviewer: reviewer,
      reviewer_email: email,
      rating: rating,
    );
    print("Login Response:---" + addReviewModel.reviewer.toString());
  }
}
