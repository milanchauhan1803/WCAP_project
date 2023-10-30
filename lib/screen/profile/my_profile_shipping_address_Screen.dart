import 'package:ecommerce_app/model/cart_list_model.dart';
import 'package:ecommerce_app/model/customerBillingAddress.dart';
import 'package:ecommerce_app/model/customer.dart';
import 'package:ecommerce_app/model/customerShippingAddress.dart';
import 'package:ecommerce_app/screen/profile/my_profile_screen.dart';
import 'package:ecommerce_app/utilities/select_country_state.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../ApiClient/api_client.dart';
import '../../utilities/app_constants.dart';
import '../../utilities/preference_utils.dart';
import '../cart.dart';

class MyProfileShippingAddressScreen extends StatefulWidget {
  static const routeName = '/my_profile_shipping_address';

  const MyProfileShippingAddressScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileShippingAddressScreen> createState() =>
      _MyProfileShippingAddressScreenState();
}

class _MyProfileShippingAddressScreenState
    extends State<MyProfileShippingAddressScreen> {
  Customer? _getCustomer;
  CustomerShippingAddress? _customerShippingAddress;
  var firstName,lastName,addressOne,addressTwo,city,postCode,phoneNumber,email;
  bool isInit = true;
  final _formKey = GlobalKey<FormState>();
  /*final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final companyController = TextEditingController();
  final addressOneController = TextEditingController();
  final addressTwoController = TextEditingController();
  final cityController = TextEditingController();
  final postcodeController = TextEditingController();*/
  String getCountry = "";
  String getState = "";
  var customerId;

  /*@override
  void initState() {
    super.initState();
  }

  getInit() async {
    await PreferenceUtils.getInit();
    var user = await PreferenceUtils.getUserInfo(AppConstants.user);
    customerId = user.id!;
  }*/

  @override
  void didChangeDependencies() {
    if(isInit){
      if (ModalRoute.of(context)!.settings.arguments != null) {
        if (ModalRoute.of(context)!.settings.arguments is Customer) {
          _getCustomer = ModalRoute.of(context)!.settings.arguments as Customer;
          _customerShippingAddress = _getCustomer!.shipping;
        }
        else if (ModalRoute.of(context)!.settings.arguments is CustomerCart) {
          var customerCart =
          ModalRoute.of(context)!.settings.arguments as CustomerCart;
          var billing = customerCart.billingAddress;
          var shipping = customerCart.shippingAddress;

          var _customerBillingAddress = CustomerBillingAddress(
              firstName: billing!.billingFirstName!,
              lastName: billing.billingLastName!,
              //;company: billing.billingCompany!,
              address1: billing.billingAddress1!,
              address2: billing.billingAddress2!,
              city: billing.billingCity!,
              postcode: billing.billingPostcode!,
              country: billing.billingCountry!,
              state: billing.billingState!,
              email: billing.billingEmail!,
              phone: billing.billingPhone!);

          _customerShippingAddress = CustomerShippingAddress(
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
              billing: _customerBillingAddress,
              shipping: _customerShippingAddress!);
        }

        firstName = _customerShippingAddress!.firstName;
        lastName = _customerShippingAddress!.lastName;
        addressOne = _customerShippingAddress!.address1;
        addressTwo = _customerShippingAddress!.address2;
        city = _customerShippingAddress!.city;
        postCode = _customerShippingAddress!.postcode;
        getCountry = _customerShippingAddress!.country;
        getState = _customerShippingAddress!.state;

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
        title: const Text("Shipping Address"),
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
                        /*const SizedBox(height: 10),
                        TextFormField(
                          controller: companyController,
                          decoration: const InputDecoration(
                            labelText: 'Company Name',
                            // hintText: 'Досмухамедова 2В',
                            border: OutlineInputBorder(),
                          ),
                        ),*/
                        const SizedBox(height: 10),
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
                            getCountry = value;
                          },
                          onStateChanged: (value) {
                            getState = value;
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
    var getShippingAddress = CustomerShippingAddress(
        firstName: firstName,
        lastName: lastName,
        address1: addressOne,
        address2: addressTwo,
        city: city,
        postcode: postCode,
        country: getCountry,
        state: getState,
        phone: _getCustomer!.shipping.phone);
    final items = await apiClient.updateCustomerShippingAddress(
        _getCustomer!.id.toString(),
        shippingAddress: getShippingAddress);
    if (ModalRoute.of(context)!.settings.arguments is CustomerCart) {
      Navigator.of(context).pushNamedAndRemoveUntil(CartScreen.routeName, (Route<dynamic> route) => false);
    } else{
      Navigator.of(context).pushNamedAndRemoveUntil(MyProfileScreen.routeName, (Route<dynamic> route) => false);
    }
  }
}
