import 'package:ecommerce_app/screen/reviews_list.dart';
import 'package:ecommerce_app/utilities/product_details_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/provider/products.dart';

import '../../ApiClient/api_client.dart';
import '../../model/product.dart';
import '../../provider/cart.dart';
import '../../provider/reviews.dart';
import '../../utilities/app_constants.dart';
import '../../utilities/common_utilities.dart';
import '../../widget/product/product_item.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
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
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    final productDetailsArguments =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    final relatedProducts = productDetailsArguments.listRelatedProducts;
    final productId = productDetailsArguments.productId;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    final reviews = Provider.of<Reviews>(context);
    final reviewsList = reviews.items;
    reviewsList;
    var productPrice = loadedProduct.price!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.name.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addToCart(context, loadedProduct, cart);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.shopping_cart),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    loadedProduct.images![0].src.toString(),
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    productPrice.toString() +
                        " " +
                        AppConstants.currencySymbol,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    loadedProduct.name.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  child: Html(
                    data: loadedProduct.description,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (relatedProducts.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "More Like this",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                if (relatedProducts.isNotEmpty)
                  const SizedBox(
                    height: 10,
                  ),
                if (relatedProducts.isNotEmpty)
                  AspectRatio(
                    aspectRatio: 428 / 225,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: relatedProducts.length,
                      itemBuilder: (context, i) => ChangeNotifierProvider.value(
                        value: relatedProducts[i],
                        child: ProductItem(
                            relatedProducts, (ProductDetailScreen).toString()),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Reviews",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _dialogBuilder(context, productId);
                      },
                      child: const Text(
                        "Add Reviews",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                ReviewsList(productId: productId),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, int productId) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 0),
            content: SingleChildScrollView(
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
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 14)),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                      hintText: "Name",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 14)),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 14)),
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
                              msg:
                                  "Please, select stars and give us your review",
                              backgroundColor: Colors.grey);
                        } else if (reviewController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg:
                                  "Please, Write your review.\n it's can't be empty",
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
                          createCustomerReview(
                            productId,
                            reviewController.text,
                            emailController.text,
                            nameController.text,
                            ratings,
                          );
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
            ),
          );
        });
  }

  addToCart(BuildContext context, Product product, Cart cart) async {
    var addtocart;

    if (product.type == AppConstants.grouped) {
      var obj = {};
      for (var i = 0; i < product.groupedProducts!.length; i++) {
        obj[product.groupedProducts!.elementAt(i).toString()] = 1;
      }
      print("CartGroup:--" + obj.toString());
      addtocart = await cart.addItem(product.id.toString(), "1", obj, false);
    } else {
      addtocart = await cart.addItem(product.id.toString(), "1", {}, false);

      print("objectAddToCart:--" + addtocart.toString());
      print("objectAddToCart:--" + addtocart.cartHash.toString());
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
  }

  Future<void> createCustomerReview(
      int productId,
      String review,
      String reviewerEmail,
      String reviewer,
      double rating,
      ) async {
    final apiClient = ApiClient();

    final createCustomerReviewRes = await apiClient.addProductReview(
      product_id: productId,
      review: review,
      reviewer: reviewer,
      reviewer_email: reviewerEmail,
      rating: rating,
    );

    if (createCustomerReviewRes != null && createCustomerReviewRes.id != null) {
      Provider.of<Reviews>(context, listen: false).loadingReviews().then(
            (_) {
          setState(() {
            _isLoading = false;
            CommonUtilities.showSnackBar(context, "Thank You :)");
            Navigator.of(context).pop(true);
          });
        },
      );


      // final reviews = Provider.of<Reviews>(context);
      // final reviewsList = reviews.items;

      // saveData(firstName, lastName, email, username, password);
    }
  }
}
