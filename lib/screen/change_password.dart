import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:ecommerce_app/screen/sign_in.dart';
import 'package:ecommerce_app/utilities/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utilities/preference_utils.dart';

class ChangePassword extends StatefulWidget {
  static const routeName = '/changePassword';

  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  String? oldPassword = PreferenceUtils.getString(AppConstants.password);
  String? newPassword = "";
  String? confNewPassword = "";
  bool _isObscure = true;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(oldPassword);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        onChanged: (value) {
                          oldPassword = value;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Old Password",
                          hintText: "Enter old password",
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Please enter old password";
                          }
                          if (value != oldPassword) {
                            return "You entered wrong password";
                          }
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                        onChanged: (value) {
                          newPassword = value;
                        },
                        decoration: const InputDecoration(
                          labelText: "New Password",
                          hintText: "Enter new password",
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Please enter new password";
                          }
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          confNewPassword = value;
                        },
                        decoration: const InputDecoration(
                          labelText: "Confirm Password",
                          hintText: "Enter confirm password",
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Please confirm new password";
                          }
                          if (newPassword != confNewPassword) {
                            return "New password and confirm password does not match.";
                          }
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      updatePassword(confNewPassword!, context);
                    });
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: const Center(
                      child: Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> updatePassword(String password, BuildContext context) async {
  int? id = PreferenceUtils.getInt(AppConstants.customerId);
  final apiClient = ApiClient();
  final items =
      await apiClient.changePassword(customerId: id, password: password);
  Fluttertoast.showToast(
      msg: "Password has been successfully changed",
      backgroundColor: Colors.grey);
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.getInit();
  PreferenceUtils.clear();

  Navigator.of(context).pushNamedAndRemoveUntil(
    SignInScreen.routeName,
    (Route<dynamic> route) => false,
  );
  print(items.firstName);
}