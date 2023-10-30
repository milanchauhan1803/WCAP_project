import 'package:ecommerce_app/screen/orders_list.dart';
import 'package:ecommerce_app/screen/sign_in.dart';
import 'package:flutter/material.dart';

import '../screen/categories.dart';
import '../screen/product/product_overview_screen.dart';
import '../screen/profile/my_profile_screen.dart';
import '../utilities/common_utilities.dart';
import '../utilities/preference_utils.dart';

// Navigation

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('WooCommerce'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Products'),
            onTap: () {
              Navigator.of(context).popAndPushNamed(ProductOverviewScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
            onTap: () {
              Navigator.of(context).popAndPushNamed(CategoriesScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shopping_cart_outlined),
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context).popAndPushNamed(OrdersListScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('My Profile'),
            onTap: () {
              Navigator.of(context).popAndPushNamed(MyProfileScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              CommonUtilities.showUtilDialog(
                  context,
                  AlertDialog(
                    title:  const Text("Logout", style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
                    content: const Text("Are you sure you want to logout?",style: TextStyle(fontSize: 14.0)),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          WidgetsFlutterBinding.ensureInitialized();
                          await PreferenceUtils.getInit();
                          PreferenceUtils.clear();

                          Navigator.of(context).pushNamedAndRemoveUntil(SignInScreen.routeName,(Route<dynamic> route) => false,);
                        },
                        child: const Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text("No"),
                      ),
                    ],
                  )
              );
            },
          ),
          const Divider()
        ],
      ),
    );
  }
}
