import 'package:ecommerce_app/model/CreateCustomerMdoel.dart';
import 'package:ecommerce_app/model/cart_list_model.dart';
import 'package:ecommerce_app/model/customerBillingAddress.dart';
import 'package:ecommerce_app/model/customer.dart';
import 'package:ecommerce_app/screen/cart.dart';
import 'package:ecommerce_app/screen/profile/my_profile_screen.dart';
import 'package:ecommerce_app/utilities/select_country_state.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../ApiClient/api_client.dart';
import '../../model/customerShippingAddress.dart';
import '../../utilities/app_constants.dart';
import '../../utilities/preference_utils.dart';

class MyProfileBillingAddressScreen extends StatefulWidget {
  static const routeName = '/my_profile_billing_address';

  const MyProfileBillingAddressScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileBillingAddressScreen> createState() =>
      _MyProfileBillingAddressScreenState();
}

class _MyProfileBillingAddressScreenState
    extends State<MyProfileBillingAddressScreen> {
  Customer? _getCustomer;
  CustomerBillingAddress? _customerBillingAddress;
  var firstName,lastName,addressOne,addressTwo,city,postCode,phoneNumber,email;
  String getCountry = "";
  String getState = "";
  var customerId;
  bool isInit = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    if(isInit){
      if (ModalRoute.of(context)!.settings.arguments != null) {
        if (ModalRoute.of(context)!.settings.arguments is Customer) {
          _getCustomer = ModalRoute.of(context)!.settings.arguments as Customer;
          _customerBillingAddress = _getCustomer!.billing;
        }
        else if (ModalRoute.of(context)!.settings.arguments is CustomerCart) {
          var customerCart =
          ModalRoute.of(context)!.settings.arguments as CustomerCart;
          var billing = customerCart.billingAddress;
          var shipping = customerCart.shippingAddress;

          _customerBillingAddress = CustomerBillingAddress(
              firstName: billing!.billingFirstName!,
              lastName: billing.billingLastName!,
              //company: billing.billingCompany!,
              address1: billing.billingAddress1!,
              address2: billing.billingAddress2!,
              city: billing.billingCity!,
              postcode: billing.billingPostcode!,
              country: billing.billingCountry!,
              state: billing.billingState!,
              email: billing.billingEmail!,
              phone: billing.billingPhone!);

          var _customerShippingAddress = CustomerShippingAddress(
              firstName: shipping!.shippingFirstName!,
              lastName: shipping.shippingLastName!,
              //company: shipping.shippingCompany!,
              address1: shipping.shippingAddress1!,
              address2: shipping.shippingAddress2!,
              city: shipping.shippingCity!,
              postcode: shipping.shippingPostcode!,
              country: shipping.shippingCountry!,
              state: shipping.shippingState!,
              phone: "");

          _getCustomer = Customer(
              id: int.parse(AppConstants.customerID),
              first_name: "",
              last_name: "",
              email: "",
              role: "customer",
              username: "",
              billing: _customerBillingAddress!,
              shipping: _customerShippingAddress);
        }

        firstName = _customerBillingAddress!.firstName;
        lastName = _customerBillingAddress!.lastName;
        addressOne = _customerBillingAddress!.address1;
        addressTwo = _customerBillingAddress!.address2;
        city = _customerBillingAddress!.city;
        postCode = _customerBillingAddress!.postcode;
        phoneNumber = _customerBillingAddress!.phone;
        email = _customerBillingAddress!.email;
        getCountry = _customerBillingAddress!.country;
        getState = _customerBillingAddress!.state;

        setState(() {
          isInit = false;
        });
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Billing Address"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: firstName,
                          onChanged: (String? value) {
                            firstName = value?.trim() ?? "";
                          },
                          validator: (String? value) {
                            return (value?.isEmpty ?? true)
                                ? "Please enter first name"
                                : null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            // hintText: 'Турар',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: lastName,
                          onChanged: (String? value) {
                            lastName = value?.trim() ?? "";
                          },
                          validator: (String? value) {
                            return (value?.isEmpty ?? true)
                                ? "Please enter last name"
                                : null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            // hintText: 'Тураров',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        /*TextFormField(
                          initialValue: company,
                          onChanged: (String? value) {
                            company = value?.trim() ?? "";
                          },
                          validator: (String? value) {
                            return (value?.isEmpty ?? true)
                                ? "Please enter company name"
                                : null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Company Name',
                            // hintText: 'Досмухамедова 2В',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),*/
                        TextFormField(
                          initialValue: addressOne,
                          onChanged: (String? value) {
                            addressOne = value?.trim() ?? "";
                          },
                          validator: (String? value) {
                            return (value?.isEmpty ?? true)
                                ? "Please enter street address 1"
                                : null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Street Address 1',
                            // hintText: 'Досмухамедова 2В',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: addressTwo,
                          onChanged: (String? value) {
                            addressTwo = value?.trim() ?? "";
                          },
                          validator: (String? value) {
                            return (value?.isEmpty ?? true)
                                ? "Please enter street address 2"
                                : null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Street Address 2',
                            // hintText: '4 подьезд, 2 этаж, 32 квартира',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: city,
                          onChanged: (String? value) {
                            city = value?.trim() ?? "";
                          },
                          validator: (String? value) {
                            return (value?.isEmpty ?? true)
                                ? "Please enter city name"
                                : null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'City',
                            // hintText: 'Алматы',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SelectCountryState(
                          onCountryChanged: (value) {
                            setState(() {
                              getCountry = value;
                            });
                          },
                          onStateChanged: (value) {
                            setState(() {
                              getState = value;
                            });
                          },
                          selectedCountry: getCountry,
                          selectedState: getState,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: postCode,
                          keyboardType: TextInputType.number,
                          onChanged: (String? value) {
                            postCode = value?.trim() ?? "";
                          },
                          validator: (String? value) {
                            return (value?.isEmpty ?? true)
                                ? "Please enter post code"
                                : null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Postcode',
                            // hintText: '050000',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: phoneNumber,
                          keyboardType: TextInputType.number,
                          onChanged: (String? value) {
                            phoneNumber = value?.trim() ?? "";
                          },
                          validator: (String? value) {
                            return (value?.isEmpty ?? true)
                                ? "Please enter phone number"
                                : null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Phone',
                            prefixText: '+ 91 ',
                            // hintText: '123-456-78-90',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: email,
                          onChanged: (String? value) {
                            phoneNumber = value?.trim() ?? "";
                          },
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return "Please enter email id";
                            }
                            bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value ?? "");
                            return emailValid ? null : "Please enter valid email id";
                          },
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            // hintText: 'admin@sonoff.kz',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              InkWell(
                onTap: () {
                  if(_formKey.currentState!.validate()){
                    updateCustomer();
                  }
                },
                child: Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: MediaQuery.of(context).size.width,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateCustomer() async {
    final apiClient = ApiClient();
    var getBillingAddress = CustomerBillingAddress(
        firstName: firstName,
        lastName: lastName,
        //company: company,
        address1: addressOne,
        address2: addressTwo,
        city: city,
        postcode: postCode,
        country: getCountry,
        state: getState,
        email: email,
        phone: phoneNumber);
    final items = await apiClient.updateCustomerBillingAddress(
        _getCustomer!.id.toString(),
        billingAddress: getBillingAddress);
    if (items.id != null) {
      if (ModalRoute.of(context)!.settings.arguments is CustomerCart) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            CartScreen.routeName, (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            MyProfileScreen.routeName, (Route<dynamic> route) => false);
      }
    }
  }
}
