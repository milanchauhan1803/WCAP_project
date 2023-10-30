import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_app/model/LoginModel.dart';
import 'package:ecommerce_app/model/add_reviews_model.dart';
import 'package:ecommerce_app/model/cart_error_model.dart';
import 'package:ecommerce_app/model/coupon.dart';
import 'package:ecommerce_app/model/create_order_model.dart';
import 'package:ecommerce_app/model/customerBillingAddress.dart';
import 'package:ecommerce_app/model/customerShippingAddress.dart';
import 'package:ecommerce_app/model/payment_methods_list_model.dart';
import 'package:ecommerce_app/model/place_order_error_model.dart';
import 'package:ecommerce_app/model/reviews_model.dart';
import 'package:ecommerce_app/model/shipping_methods_list_model.dart';
import 'package:ecommerce_app/utilities/app_constants.dart';
import 'package:ecommerce_app/utilities/common_utilities.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/config/config.dart';
import 'package:ecommerce_app/model/order.dart';
import 'package:ecommerce_app/model/product.dart';

import '../model/cart_list_model.dart';
import '../model/cart_model.dart';
import '../model/category.dart';
import '../model/create_customer_model.dart';
import '../model/customer.dart';
import '../screen/sign_in.dart';
import '../utilities/preference_utils.dart';

class ApiClient with ChangeNotifier {
  final client = HttpClient();
  final key = Config().key;
  final secret = Config().secret;
  final urlBase = Config().url;

  Future<dynamic> get(String ulr, bool tokenPass) async {
    final url = Uri.parse(ulr);
    final request = await client.getUrl(url);
    if (tokenPass) {
      WidgetsFlutterBinding.ensureInitialized();
      await PreferenceUtils.getInit();
      var user = await PreferenceUtils.getUserInfo(AppConstants.user);
      var token = user.token.toString();
      print("token:--" + token);

      request.headers.set("Authorization", "Bearer $token");
    }
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final dynamic json = jsonDecode(jsonString);
    return json;
  }

  Future<dynamic> post(String ulr, dynamic parameters, bool tokenPass) async {
    final url = Uri.parse(ulr);
    final request = await client.postUrl(url);
    request.headers.set("Content-Type", "application/json; charset=utf-8");
    if (tokenPass) {
      WidgetsFlutterBinding.ensureInitialized();
      await PreferenceUtils.getInit();
      var user = await PreferenceUtils.getUserInfo(AppConstants.user);
      var token = user.token.toString();
      print("token:--" + token);

      request.headers.set("Authorization", "Bearer $token");
    }

    request.write(jsonEncode(parameters));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    print("parameters:--" + json.toString());
    return json;
  }

  Future<dynamic> delete(String ulr, dynamic parameters, bool tokenPass) async {
    final url = Uri.parse(ulr);
    final request = await client.deleteUrl(url);
    request.headers.set("Content-Type", "application/json; charset=utf-8");
    if (tokenPass) {
      WidgetsFlutterBinding.ensureInitialized();
      await PreferenceUtils.getInit();
      var user = await PreferenceUtils.getUserInfo(AppConstants.user);
      var token = user.token.toString();
      print("token:--" + token);

      request.headers.set("Authorization", "Bearer $token");
    }

    if (parameters != null) {
      request.write(jsonEncode(parameters));
    }
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    print("parametersDelete:--" + json.toString());
    return json;
  }

  // Profile - Get
  Future<Customer> getCustomerData(String customerId) async {
    final json = await get(
        '$urlBase/wp-json/wc/v3/customers/$customerId?consumer_key=$key&consumer_secret=$secret',
        false) as Map<String, dynamic>;

    final customerData = Customer.fromJson(json);
    return customerData;
  }

  // Category - Get
  Future<List<Category>> getCategory() async {
    final json = await get(
        '$urlBase/wp-json/wc/v3/products/categories?consumer_key=$key&consumer_secret=$secret',
        false) as List<dynamic>;

    final categories = json
        .map((dynamic e) => Category.fromJson(e as Map<String, dynamic>))
        .toList();
    return categories;
  }

  // Category Product - Get
  Future<List<Product>> getCategoryProduct(int categoryId) async {
    final json = await get(
        '$urlBase/wp-json/wc/v3/products?category=$categoryId&consumer_key=$key&consumer_secret=$secret',
        false) as List<dynamic>;

    final products = json
        .map((dynamic e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
    return products;
  }

// Product - Get
  Future<List<Product>> getProduct() async {
    final json = await get(
        '$urlBase/wp-json/wc/v3/products?consumer_key=$key&consumer_secret=$secret',
        false) as List<dynamic>;

    final products = json
        .map((dynamic e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
    return products;
  }

  // Payment Methods List - Get
  Future<List<PaymentMethodsListModel>> getPaymentMethodsList() async {
    final json = await get(
        '$urlBase/wp-json/wc/v3/payment_gateways?consumer_key=$key&consumer_secret=$secret',
        false) as List<dynamic>;

    final paymentMethodsList = json
        .map((dynamic e) =>
            PaymentMethodsListModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return paymentMethodsList;
  }

  // Shipping Methods List - Get
  Future<List<ShippingMethodsListModel>> getShippingMethodsList() async {
    final json = await get(
        '$urlBase/wp-json/wc/v3/shipping_methods?consumer_key=$key&consumer_secret=$secret',
        false) as List<dynamic>;

    final shippingMethodsList = json
        .map((dynamic e) =>
            ShippingMethodsListModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return shippingMethodsList;
  }

  // Coupons - Get
  Future<List<Coupon>> getCoupons() async {
    final json = await get(
        '$urlBase/wp-json/wc/v3/coupons?consumer_key=$key&consumer_secret=$secret',
        false) as List<dynamic>;

    final coupons = json
        .map((dynamic e) => Coupon.fromJson(e as Map<String, dynamic>))
        .toList();
    return coupons;
  }

// Order - Get
  Future<List<Order>> getOrder(String customerId) async {
    final json = await get(
        '$urlBase/wp-json/wc/v3/orders?customer=$customerId&consumer_key=$key&consumer_secret=$secret',
        false) as List<dynamic>;

    final orders = json
        .map((dynamic e) => Order.fromJson(e as Map<String, dynamic>))
        .toList();
    return orders;
  }

  // Items Cart - Get
  Future<dynamic> getItemsCart() async {
    final json = await get('$urlBase/wp-json/cocart/v2/cart', true);
    //as List<dynamic>;

    print("CartItems:--" + json.toString());
    if (json.toString().contains("statusCode")) {
      final products = CartErrorModel.fromJson(json);
      if (products.code.toString() == "403") {
        WidgetsFlutterBinding.ensureInitialized();
        await PreferenceUtils.getInit();
        PreferenceUtils.clear();

        CommonUtilities.showSnackBar(AppConstants.navigatorKey.currentContext!,
            "Please authenticate your self again");
        Navigator.of(AppConstants.navigatorKey.currentContext!)
            .pushNamedAndRemoveUntil(
          SignInScreen.routeName,
          (Route<dynamic> route) => false,
        );
      }
      return products;
    } else {
      final products = CartListModel.fromJson(json);
      return products;
    }
  }

  // Items Cart - Get
  Future<dynamic> clearCart() async {
    final json =
        await post('$urlBase/wp-json/cocart/v2/cart/clear', null, true);
    //as List<dynamic>;

    print("CartItems:--" + json.toString());
    final products = CartModel.fromJson(json);
    return products;
  }

  //Add to cart item
  Future<dynamic> addToCart(String id, String qty,
      Map<dynamic, dynamic> qtyGrouped, bool isVariable) async {
    final parameters;
    var json;

    if (qtyGrouped.isEmpty) {
      parameters = {
        "id": id,
        "quantity": qty,
      };
      json = await post(
          '$urlBase/wp-json/cocart/v2/cart/add-item', parameters, true);
    } else if (isVariable) {
      parameters = {
        "id": id,
        "quantity": qty,
        "variation": {
          "attribute_pa_color": "Blue",
          "attribute_pa_logo": "Yes",
        }
      };
      json = await post(
          '$urlBase/wp-json/cocart/v2/cart/add-items', parameters, true);
    } else {
      parameters = {
        "id": id,
        "quantity": qtyGrouped,
      };
      json = await post(
          '$urlBase/wp-json/cocart/v2/cart/add-items', parameters, true);
    }
    print("JsonResCart;--" + json.toString());
    if (!json.toString().contains("cart_hash")) {
      return null;
    } else {
      final order = CartModel.fromJson(json);
      return order;
    }
  }

  Future<dynamic> deleteItemFromCart(String itemKey) async {
    final json = await delete(
        '$urlBase/wp-json/cocart/v2/cart/item/$itemKey', null, true);
    print("JsonResDeleteCart;--" + json.toString());
    final order = CartModel.fromJson(json);
    return order;
  }

// Create Order - POST
  Future<dynamic> createOrder(
      {required String customerId,
      required String payment_method,
      required String payment_method_title,
      required String firstName,
      required String lastName,
      required String addressOne,
      required String addressTwo,
      required String city,
      required String country,
      required String state,
      required String postcode,
      required String email,
      required String phone,
      required String shippingFirstName,
      required String shippingLastName,
      required String shippingAddressOne,
      required String shippingAddressTwo,
      required String shippingCity,
      required String shippingCountry,
      required String shippingState,
      required String shippingPostcode,
      //required String total,
      required dynamic line_items,
      required dynamic shipping_lines,
      required dynamic couponLines}) async {
    final url = Uri.parse(
      '$urlBase/wp-json/wc/v3/orders',
    );
    final parameters = <String, dynamic>{
      'payment_method_title': payment_method_title,
      'payment_method': payment_method,
      'billing': {
        'first_name': firstName,
        'last_name': lastName,
        'address_1': addressOne,
        'address_2': addressTwo,
        'city': city,
        'country': country,
        'state': state,
        'postcode': postcode,
        'email': email,
        'phone': phone,
      },
      'shipping': {
        'first_name': shippingFirstName,
        'last_name': shippingLastName,
        'address_1': shippingAddressOne,
        'address_2': shippingAddressTwo,
        'city': shippingCity,
        'country': shippingCountry,
        'state': shippingState,
        'postcode': shippingPostcode,
        'email': email,
        'phone': phone,
      },
      'coupon_lines': couponLines,
      'line_items': line_items,
      'shipping_lines': shipping_lines,
    };
    print("parameters:--" + parameters.toString());
    final json = await post(
        '$urlBase/wp-json/wc/v3/orders?customer_id=$customerId&consumer_key=$key&consumer_secret=$secret',
        parameters,
        false);
    print("parametersjson:--" + json.toString());
    if (!json.toString().contains("cart_hash")) {
      final order = PlaceOrderErrorModel.fromJson(json);
      return order;
    } else {
      final order = CreateOrderModel.fromJson(json);
      return order;
    }
  }

  Future<CreateCustomerModel> createCustomer(
      {required String email,
      required String first_name,
      required String last_name,
      required String username,
      required String password}) async {
    final url = Uri.parse(
      '$urlBase/wp-json/wc/v3/customers?consumer_key=$key&consumer_secret=$secret',
    );
    final parameters = <String, dynamic>{
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'username': username,
      'password': password,
    };
    /*final request = await client.postUrl(url);
    request.headers.set("Content-Type", "application/json; charset=utf-8");
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;*/
    final json = await post(
        '$urlBase/wp-json/wc/v3/customers?consumer_key=$key&consumer_secret=$secret',
        parameters,
        false);
    final customer = CreateCustomerModel.fromJson(json);
    return customer;
  }

  Future<CreateCustomerModel> updateCustomerBasicInfo(String customerId,
      {required String email,
      required String first_name,
      required String last_name,
      required String username}) async {
    final url = Uri.parse(
      '$urlBase/wp-json/wc/v3/customers/$customerId?consumer_key=$key&consumer_secret=$secret',
    );
    final parameters = <String, dynamic>{
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'username': username,
    };
    /*final request = await client.postUrl(url);
    request.headers.set("Content-Type", "application/json; charset=utf-8");
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;*/
    final json = await post(
        '$urlBase/wp-json/wc/v3/customers/$customerId?consumer_key=$key&consumer_secret=$secret',
        parameters,
        false);
    final customer = CreateCustomerModel.fromJson(json);
    return customer;
  }

  Future<CreateCustomerModel> updateCustomerBillingAddress(String customerId,
      {required CustomerBillingAddress billingAddress}) async {
    final url = Uri.parse(
      '$urlBase/wp-json/wc/v3/customers/$customerId?consumer_key=$key&consumer_secret=$secret',
    );
    final parameters = <String, dynamic>{
      'billing': billingAddress,
    };
    /*final request = await client.postUrl(url);
    request.headers.set("Content-Type", "application/json; charset=utf-8");
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;*/
    final json = await post(
        '$urlBase/wp-json/wc/v3/customers/$customerId?consumer_key=$key&consumer_secret=$secret',
        parameters,
        false);
    final customer = CreateCustomerModel.fromJson(json);
    return customer;
  }

  Future<CreateCustomerModel> updateCustomerShippingAddress(String customerId,
      {required CustomerShippingAddress shippingAddress}) async {
    final url = Uri.parse(
      '$urlBase/wp-json/wc/v3/customers/$customerId?consumer_key=$key&consumer_secret=$secret',
    );
    final parameters = <String, dynamic>{'shipping': shippingAddress};
    /*final request = await client.postUrl(url);
    request.headers.set("Content-Type", "application/json; charset=utf-8");
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;*/
    final json = await post(
        '$urlBase/wp-json/wc/v3/customers/$customerId?consumer_key=$key&consumer_secret=$secret',
        parameters,
        false);
    final customer = CreateCustomerModel.fromJson(json);
    return customer;
  }

  Future<LoginModel> getAuthToken({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse(
      '$urlBase/wp-json/jwt-auth/v1/token',
    );

    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
    };
    /*final request = await client.postUrl(url);
    request.headers.set("Content-Type", "application/json; charset=utf-8");
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;*/
    final json =
        await post('$urlBase/wp-json/jwt-auth/v1/token', parameters, false);
    final order = LoginModel.fromJson(json);
    return order;
  }

  //Get All Products Reviwes
  Future<List<ReviewsModel>> getReviews() async {
    final json = await get(
        '$urlBase/wp-json/wc/v3/products/reviews?consumer_key=$key&consumer_secret=$secret',
        false) as List<dynamic>;

    final reviews = json
        .map((dynamic e) => ReviewsModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return reviews;
  }

  //Add Products Reviwes

  Future<AddReviewsModel> addProductReview(
      {required int product_id,
      required String review,
      required String reviewer,
      required String reviewer_email,
      required double rating}) async {
    final parameters = <String, dynamic>{
      'product_id': product_id,
      'review': review,
      'reviewer': reviewer,
      'reviewer_email': reviewer_email,
      'rating': rating,
    };

    final json = await post(
        '$urlBase/wp-json/wc/v3/products/reviews?consumer_key=$key&consumer_secret=$secret',
        parameters,
        false);
    final customer = AddReviewsModel.fromJson(json);
    return customer;
  }

  Future<CreateCustomerModel> changePassword(
      {required int? customerId, required String password}) async {
    final url = Uri.parse(
      '$urlBase/wp-json/wc/v3/customers/$customerId?consumer_key=$key&consumer_secret=$secret',
    );
    final parameters = <String, dynamic>{
      'password': password,
    };
    /*final request = await client.postUrl(url);
    request.headers.set("Content-Type", "application/json; charset=utf-8");
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;*/
    final json = await post(
        '$urlBase/wp-json/wc/v3/customers/$customerId?consumer_key=$key&consumer_secret=$secret',
        parameters,
        false);
    final customer = CreateCustomerModel.fromJson(json);
    return customer;
  }
}
