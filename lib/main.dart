import 'package:ecommerce_app/provider/cart.dart';
import 'package:ecommerce_app/provider/coupons.dart';
import 'package:ecommerce_app/provider/orders.dart';
import 'package:ecommerce_app/provider/placeOrder.dart';
import 'package:ecommerce_app/provider/products.dart';
import 'package:ecommerce_app/provider/reviews.dart';
import 'package:ecommerce_app/screen/change_password.dart';
import 'package:ecommerce_app/screen/forgot_password.dart';
import 'package:ecommerce_app/screen/order_details.dart';
import 'package:ecommerce_app/provider/paymet_methods_list.dart';
import 'package:ecommerce_app/provider/shipping_methods_list.dart';
import 'package:ecommerce_app/screen/orders_list.dart';
import 'package:ecommerce_app/screen/profile/my_profile_basic_info_screen.dart';
import 'package:ecommerce_app/screen/profile/my_profile_billing_address_screen.dart';
import 'package:ecommerce_app/screen/profile/my_profile_shipping_address_Screen.dart';
import 'package:ecommerce_app/screen/reviews_list.dart';
import 'package:ecommerce_app/screen/sign_in.dart';
import 'package:ecommerce_app/screen/sign_up.dart';
import 'package:ecommerce_app/utilities/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_app/screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'provider/categories.dart';
import 'provider/customers.dart';
import 'screen/categories.dart';
import 'screen/profile/my_profile_screen.dart';

/*void main() {
  runApp(const MyApp());
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init a shared preferences variable
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isLoggedIn = false;
  if (prefs.getBool(AppConstants.login) != null) {
    isLoggedIn = prefs.getBool(AppConstants.login)!;
  } else {
    isLoggedIn = false;
  }

  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isLoggedIn;

  const MyApp({Key? key, this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Categories(),
        ),
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlaceOrder(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
        ChangeNotifierProvider(
          create: (context) => Customers(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentMethodsList(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShippingMethodsList(),
        ),
        ChangeNotifierProvider(
          create: (context) => Coupons(),
        ),
        ChangeNotifierProvider(
          create: (context) => Reviews(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          focusColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        navigatorKey: AppConstants.navigatorKey,
        home: isLoggedIn! ? const ProductOverviewScreen() : const SignInScreen(),
        routes: {
          ReviewsList.routeName: (context) => const ReviewsList(),
          ProductOverviewScreen.routeName: (context) =>
              const ProductOverviewScreen(),
          CategoriesScreen.routeName: (context) => const CategoriesScreen(),
          ProductDetailScreen.routeName: (context) =>
              const ProductDetailScreen(),
          ChangePassword.routeName: (context) => const ChangePassword(),
          ForgotPassword.routeName: (context) => const ForgotPassword(),
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          SignInScreen.routeName: (context) => const SignInScreen(),
          ChangePassword.routeName: (context) => const ChangePassword(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersListScreen.routeName: (context) => const OrdersListScreen(),
          OrderDetailsScreen.routeName: (context) => const OrderDetailsScreen(),
          MyProfileScreen.routeName: (context) => const MyProfileScreen(),
          MyProfileBasicInfoScreen.routeName: (context) =>
              const MyProfileBasicInfoScreen(),
          MyProfileBillingAddressScreen.routeName: (context) =>
              const MyProfileBillingAddressScreen(),
          MyProfileShippingAddressScreen.routeName: (context) =>
              const MyProfileShippingAddressScreen(),
        },
      ),
    );
  }
}
