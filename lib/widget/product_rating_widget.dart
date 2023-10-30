import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../ApiClient/api_client.dart';
import '../provider/cart.dart';
import '../provider/reviews.dart';
import '../screen/sign_in.dart';
import '../utilities/app_constants.dart';
import '../utilities/common_utilities.dart';
import '../utilities/preference_utils.dart';

class ProductRatingWidget extends StatefulWidget {
  final productId;

  const ProductRatingWidget({Key? key, this.productId}) : super(key: key);

  @override
  State<ProductRatingWidget> createState() => _ProductRatingWidgetState();
}

class _ProductRatingWidgetState extends State<ProductRatingWidget> {
  TextEditingController reviewController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final apiClient = ApiClient();
  var customerId;
  double ratings = 0;
  var _isInit = true;
  var _isLoading = false;

  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";

  @override
  void initState() {
    super.initState();
    // getInit();
  }

  // getInit() async {
  //   await PreferenceUtils.getInit();
  //   var user = await PreferenceUtils.getUserInfo(AppConstants.user);
  //   customerId = user.id.toString();
  //   AppConstants.customerID = customerId;
  // }
  //
  // void didChangeDependancies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //
  //     Provider.of<Reviews>(context).loadingReviews().then(
  //           (_) {
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       },
  //     );
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.blue),
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Text(
                "Add a review",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  RatingBar.builder(
                    itemSize: 40,
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemBuilder: (context, int) => const Icon(
                      Icons.star,
                      color: Colors.blue,
                      size: 12,
                    ),
                    onRatingUpdate: (rating) {
                      ratings = rating;
                      print(ratings);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: reviewController,
                          decoration: const InputDecoration(
                              hintText: "Your review",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              hintText: "Name",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              hintText: "Email",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                RegExp regex = RegExp(pattern);
                if (ratings <= 0) {
                  Fluttertoast.showToast(
                      msg: "Please, select stars and give us your review",
                      backgroundColor: Colors.grey);
                } else if (reviewController.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Please, Write your review.\n it's can't be empty",
                      backgroundColor: Colors.grey);
                } else if (nameController.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Please enter full name",
                      backgroundColor: Colors.grey);
                } else if (emailController.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Please enter your email",
                      backgroundColor: Colors.grey);
                } else if (!regex.hasMatch(emailController.text)) {
                  Fluttertoast.showToast(
                      msg: "Please enter valid email address!",
                      backgroundColor: Colors.grey);
                } else {
                  createCustomerReview(widget.productId, reviewController.text,
                      emailController.text, nameController.text, ratings);
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Colors.blue),
                height: 60,
                child: const Center(
                    child: Text(
                  "Save",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> createCustomerReview(int productId, String review,
      String reviewerEmail, String reviewer, double rating) async {
    final apiClient = ApiClient();

    final createCustomerReviewRes = await apiClient.addProductReview(
      product_id: productId,
      review: review,
      reviewer: reviewer,
      reviewer_email: reviewerEmail,
      rating: rating,
    );

    if (createCustomerReviewRes != null && createCustomerReviewRes.id != null) {
      CommonUtilities.showSnackBar(context, "Thank You :)");
      // final reviews = Provider.of<Reviews>(context);
      // final reviewsList = reviews.items;

      Navigator.of(context).pop(true);
      // saveData(firstName, lastName, email, username, password);
    }
  }
}
