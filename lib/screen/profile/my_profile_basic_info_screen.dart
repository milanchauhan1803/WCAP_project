import 'package:ecommerce_app/screen/change_password.dart';
import 'package:ecommerce_app/utilities/app_constants.dart';
import 'package:ecommerce_app/utilities/preference_utils.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/model/customer.dart';
import 'package:ecommerce_app/screen/profile/my_profile_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../ApiClient/api_client.dart';
import '../../widget/product_ratings_item.dart';
import '../change_password.dart';

class MyProfileBasicInfoScreen extends StatefulWidget {
  static const routeName = '/my_profile_basic_info';

  const MyProfileBasicInfoScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileBasicInfoScreen> createState() =>
      _MyProfileBasicInfoScreenState();
}

class _MyProfileBasicInfoScreenState extends State<MyProfileBasicInfoScreen> {
  Customer? _getCustomer;
  bool isInit = true;
  final _formKey = GlobalKey<FormState>();
  var firstName, lastName, userName, email;

  @override
  void didChangeDependencies() {
    if (isInit) {
      if (ModalRoute
          .of(context)!
          .settings
          .arguments != null) {
        _getCustomer = ModalRoute
            .of(context)!
            .settings
            .arguments as Customer;

        firstName = _getCustomer!.first_name;
        lastName = _getCustomer!.last_name;
        userName = _getCustomer!.username;
        email = _getCustomer!.email;
      }
      setState(() {
        isInit = false;
      });
    }
    //var id = PreferenceUtils.getInt(AppConstants.customerId);
    //print("id is "+id.toString());

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Info"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        initialValue: firstName,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          // hintText: 'Турар',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String? value) {
                          firstName = value?.trim() ?? "";
                        },
                        validator: (String? value) {
                          return (value?.isEmpty ?? true)
                              ? "Please enter first name"
                              : null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: TextFormField(
                        initialValue: lastName,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          // hintText: 'Тураров',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String? value) {
                          lastName = value?.trim() ?? "";
                        },
                        validator: (String? value) {
                          return (value?.isEmpty ?? true)
                              ? "Please enter last name"
                              : null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: TextFormField(
                    enabled: false,
                    initialValue: userName,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      // hintText: 'Досмухамедова 2В',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: TextFormField(
                    enabled: false,
                    initialValue: email,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      // hintText: 'admin@sonoff.kz',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ChangePassword.routeName);
                        },
                        child: const Text(
                          "Change password",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        )),
                    const Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.blue,
                      size: 17,
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      updateCustomer();
                    }
                  },
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: const Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateCustomer() async {
    final apiClient = ApiClient();
    final items = await apiClient.updateCustomerBasicInfo(
        _getCustomer!.id.toString(),
        email: email,
        first_name: firstName,
        last_name: lastName, username: userName);
    Navigator.of(context).pushNamed(MyProfileScreen.routeName);
  }
}
