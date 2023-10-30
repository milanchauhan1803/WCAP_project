import 'dart:async';

import 'package:ecommerce_app/screen/product/product_overview_screen.dart';
import 'package:ecommerce_app/screen/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    loginCheck();
  }

  Future<void> loginCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(AppConstants.login) != null) {
      isLoggedIn = prefs.getBool(AppConstants.login)!;
    } else {
      isLoggedIn = false;
    }
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext) => isLoggedIn!
                  ? const ProductOverviewScreen()
                  : const SignInScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        const Positioned.fill(
            child: Image(
          image: AssetImage("assets/images/splash.png"),
          fit: BoxFit.fill,
        )),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Center(
                child: Image.asset(
                  "assets/images/woo_logo.png",
                  height: 250,
                  width: 250,
                ),
              ),
              Column(
                children: const [
                  Text(
                    "@copyright Builderfly 2022",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
