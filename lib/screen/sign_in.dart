import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:ecommerce_app/screen/forgot_password.dart';
import 'package:ecommerce_app/screen/product/product_overview_screen.dart';
import 'package:ecommerce_app/screen/reviews_list.dart';
import 'package:ecommerce_app/screen/sign_up.dart';
import 'package:ecommerce_app/utilities/common_utilities.dart';
import 'package:flutter/material.dart';

import '../utilities/app_constants.dart';
import '../utilities/preference_utils.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signin';

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var uname="shomil.builderfly@gmail.com",password="123456789";
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  void initState() {
    getInit();
  }

  getInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    await PreferenceUtils.getInit();
  }

  @override
  Widget build(BuildContext context) {

    // final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
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
                      "Login",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Welcome, Enter your login details to enter",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Card(
                    elevation: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 25),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              //controller: TextEditingController(),
                              onChanged: (String? value) {
                                uname = value?.trim() ?? "";
                              },
                              decoration: const InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  )),
                              validator: (String? value) {
                                if (value?.isEmpty ?? true) {
                                  return "Please enter email id";
                                }
                                bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value ?? "");
                                return emailValid ? null : "Please enter valid email id";
                              },
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              //controller: TextEditingController(),
                              obscureText: _isObscure,
                              onChanged: (String? value) {
                                password = value?.trim() ?? "";
                              },
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: const TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                    icon: Icon(
                                      _isObscure ? Icons.visibility : Icons.visibility_off,
                                    ),
                                )
                              ),
                              validator: (dynamic value) {
                                if (value?.isEmpty ?? true) {
                                  return "Please enter password";
                                }

                                if (value?.length >= 12 ||
                                    value?.length <= 6) {
                                  return "Please enter check password you've entered";
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(SignUpScreen.routeName);
                                  },
                                  child: const Text(
                                    "Sign up.",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(ForgotPassword.routeName);
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            /* InkWell(
                            onTap: () {},
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ),*/
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              isLoading ? Container(
                margin: const EdgeInsets.all(25.0),
                child: const CircularProgressIndicator(),
              )
                  : InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                        getAuthToken(uname, password);
                      });
                    }},
                  child: Card(
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
                                "Login",
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
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getAuthToken(String username, String password) async {
    final apiClient = ApiClient();
    final tokenModel =
    await apiClient.getAuthToken(username: username, password: password);
    if(tokenModel.success != null && tokenModel.success!){
      CommonUtilities.showSnackBar(context, "Logged In Successfully");
      await PreferenceUtils.setKeyBool(AppConstants.login,true);
      await PreferenceUtils.setString(AppConstants.password,password);
      await PreferenceUtils.saveUserInfo(AppConstants.user,tokenModel.data);
      await PreferenceUtils.setIntValue(AppConstants.customerId,tokenModel.data!.id);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext) =>
              const ProductOverviewScreen()));
      setState(() {
        isLoading = false;
      });
    }else{
      setState(() {
        isLoading = false;
      });
      CommonUtilities.showSnackBar(context, "Login failed, please try again");
    }
    print("loginresponse:---");
    print(tokenModel.data != null ? tokenModel.data!.toString() : tokenModel.success);
    print("loginresponse:---");
  }
}