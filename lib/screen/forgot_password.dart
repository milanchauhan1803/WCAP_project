import 'package:ecommerce_app/model/forgotpass_model.dart';
import 'package:ecommerce_app/network_services/apis.dart';
import 'package:ecommerce_app/network_services/response/status.dart';
import 'package:ecommerce_app/utilities/loading.dart';
import 'package:ecommerce_app/view_model/viewmodel_forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = '/forgotPassword';

  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var uname="shomil.builderfly@gmail.com",password="12345678";
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  TextEditingController emailIdController = TextEditingController();
  final ViewModelForgotPassword viewModelForgotPassword =
      ViewModelForgotPassword();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<ViewModelForgotPassword>(
        create: (BuildContext context) => viewModelForgotPassword,
        child: Consumer<ViewModelForgotPassword>(
          builder: (context, viewModel, Widget) {
            switch (viewModel.forgotPassApi.status) {
              case Status.LOADING:
                return const Padding(
                  padding: EdgeInsets.only(top: 0, bottom: 0),
                  child: Loading(),
                );
              case Status.ERROR:
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  print(viewModel.forgotPassApi.message);
                  uiWidget();
                });
                break;
              case Status.COMPLETED:
                if (viewModel.forgotPassApi.data! != null) {
                  if (viewModel.forgotPassApi.data!.code == 200) {
                    Fluttertoast.showToast(
                        msg: viewModel.forgotPassApi.data!.msg.toString(),
                        backgroundColor: Colors.grey);
                  } else {
                    Fluttertoast.showToast(
                        msg: viewModel.forgotPassApi.data!.msg.toString(),
                        backgroundColor: Colors.grey);
                  }
                  return uiWidget();
                } else {
                  return uiWidget();
                }
                break;
              default:
            }
            return uiWidget();
          },
        ),
      ),
    );
  }

  Widget uiWidget() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Forgot Password",
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
                      //controller: emailIdController,
                      onChanged: (String? value) {
                        uname = value?.trim() ?? "";
                      },
                      decoration: const InputDecoration(
                          hintText: "Email Id",
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
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: Center(
                      child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          viewModelForgotPassword.forgotPasswordAPICall(
                              Apis.Forgot_PASS_URL +
                                  "login="+uname);
                        });
                      }


                    },
                    child: const Text(
                      "Reset Password",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
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
