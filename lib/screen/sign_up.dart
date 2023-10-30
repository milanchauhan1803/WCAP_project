import 'dart:convert';

import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:ecommerce_app/screen/product/product_overview_screen.dart';
import 'package:ecommerce_app/screen/sign_in.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/create_customer_model.dart';
import '../utilities/common_utilities.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();

  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Create account",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      // const Align(
                      //   alignment: Alignment.topLeft,
                      //   child: Text(
                      //     "Register to keep track of your wishlists, cart and orders",
                      //     style: TextStyle(
                      //         color: Colors.grey,
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 15),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      Card(
                        elevation: 3,
                        child: Form(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 25),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                            hintText: "First name",
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            )),
                                        controller: firstNameController,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        decoration: const InputDecoration(
                                            hintText: "Last name",
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            )),
                                        controller: lastNameController,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Username",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  controller: usernameController,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  controller: emailController,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                  obscureText: true,
                                  controller: passwordController,
                                  validator: (value) =>
                                      EmailValidator.validate(value!)
                                          ? null
                                          : "Please Enter a valid Email",
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                      hintText: "Verify Password",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      )),
                                  obscureText: true,
                                  controller: verifyPasswordController,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(),
            Column(
              children: [
                InkWell(
                    onTap: () {
                      RegExp regex = RegExp(pattern);
                      if (firstNameController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please enter first name",
                            backgroundColor: Colors.grey);
                      } else if (lastNameController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please enter last name",
                            backgroundColor: Colors.grey);
                      } else if (usernameController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please enter Username.",
                            backgroundColor: Colors.grey);
                      } else if (emailController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please enter your email address ",
                            backgroundColor: Colors.grey);
                      } else if (emailController.text.isEmpty ||
                          !regex.hasMatch(emailController.text)) {
                        Fluttertoast.showToast(
                            msg: "Please enter valid email address",
                            backgroundColor: Colors.grey);
                      } else if (passwordController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please enter valid password.",
                            backgroundColor: Colors.grey);
                      } else if (passwordController.text.length >= 12 ||
                          passwordController.text.length <= 6) {
                        Fluttertoast.showToast(
                            msg:
                                "Please enter password minimum 6 letters or maximum 12 letters.",
                            backgroundColor: Colors.grey);
                      } else if (verifyPasswordController.text.isEmpty ||
                          passwordController.text !=
                              verifyPasswordController.text) {
                        Fluttertoast.showToast(
                            msg: "Please check password you've entered.",
                            backgroundColor: Colors.grey);
                      } else if (verifyPasswordController.text.length >= 12 ||
                          verifyPasswordController.text.length <= 6) {
                        Fluttertoast.showToast(
                            msg: "Please check password you've entered.",
                            backgroundColor: Colors.grey);
                      } else {
                        createCustomer(
                            firstNameController.text,
                            lastNameController.text,
                            usernameController.text,
                            emailController.text,
                            passwordController.text);
                      }
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(color: Colors.blue),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            SizedBox(),
                            Text(
                              "Create Account",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          ],
                        )),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createCustomer(String firstName, String lastName,
      String username, String email, String password) async {
    final apiClient = ApiClient();

    final createCustomerRes = await apiClient.createCustomer(
        email: email,
        first_name: firstName,
        last_name: lastName,
        username: username,
        password: password);

    if (createCustomerRes != null && createCustomerRes.id != null) {
      CommonUtilities.showSnackBar(context, "Registered Successfully");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext) => const SignInScreen()));
      saveData(firstName, lastName, email, username, password);
    }
  }

  void saveData(String firstName, String lastName, String email,
      String username, String password) {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    _prefs.then((prefs) => {
          prefs.setString("firstName", firstName),
          prefs.setString("lastName", lastName),
          prefs.setString("username", username),
          prefs.setString("email", email),
          prefs.setString("password", password),
        });
  }
}
