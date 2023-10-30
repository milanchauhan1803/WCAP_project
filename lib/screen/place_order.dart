// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerce_app/model/coupon.dart';
import 'package:ecommerce_app/model/payment_methods_list_model.dart';
import 'package:ecommerce_app/model/shipping_methods_list_model.dart';
import 'package:ecommerce_app/provider/coupons.dart';
import 'package:ecommerce_app/provider/paymet_methods_list.dart';
import 'package:ecommerce_app/provider/shipping_methods_list.dart';
import 'package:ecommerce_app/screen/product/product_overview_screen.dart';
import 'package:ecommerce_app/screen/profile/my_profile_billing_address_screen.dart';
import 'package:ecommerce_app/screen/profile/my_profile_shipping_address_Screen.dart';
import 'package:ecommerce_app/utilities/common_utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:ecommerce_app/widget/widget.dart';

import '../model/cart_list_model.dart';
import '../utilities/app_constants.dart';
import '../utilities/preference_utils.dart';

class PlaceOrderScreen extends StatefulWidget {
  final CartListModel cartListModel;
  static const routeName = '/checkout';

  const PlaceOrderScreen({Key? key, required this.cartListModel})
      : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();

/*Column _textField() {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: TextField(
                controller: firstName,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  // hintText: 'Турар',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: TextField(
                controller: secondName,
                decoration: const InputDecoration(
                    labelText: 'Surname',
                  // hintText: 'Тураров',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Flexible(
          child: TextField(
            controller: addressOne,
            decoration: const InputDecoration(
              labelText: 'Address',
              // hintText: 'Досмухамедова 2В',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Flexible(
          child: TextField(
            controller: addressTwo,
            decoration: const InputDecoration(
              labelText: 'Wing, entrance, floor, etc. (optional)',
              // hintText: '4 подьезд, 2 этаж, 32 квартира',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Flexible(
              child: TextField(
                controller: city,
                decoration: const InputDecoration(
                  labelText: 'City',
                  // hintText: 'Алматы',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: TextField(
                controller: country,
                decoration: const InputDecoration(
                  labelText: 'Province / District',
                  // hintText: 'Алмалинский',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Flexible(
          child: TextField(
            controller: postcode,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Postcode',
              // hintText: '050000',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Flexible(
          child: TextField(
            controller: phone,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Telephone',
              prefixText: '+ 7',
              // hintText: '123-456-78-90',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Flexible(
          child: TextField(
            controller: email,
            decoration: const InputDecoration(
              labelText: 'Email',
              // hintText: 'admin@sonoff.kz',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }*/
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  late CartListModel cartListModel;
  final apiClient = ApiClient();
  var _isLoading = true;
  var isLoadingPlaceOrder = false;
  var _isInit = true;
  var _isInitBuild = true;
  var paymentMethodsList;
  var _rampResult;
  var _rampResultShipping;
  var paymentMethodTitle = "",
      paymentMethod = "",
      shippingMethodId = "",
      shippingMethodTitle = "";
  bool couponCodeApplied = false;
  final couponTextHolder = TextEditingController();
  List<String> listCouponNames = [];
  var total = "";

  List<PaymentMethodsListModel>? listPaymentMethodsList;
  List<ShippingMethodsListModel>? shippingMethodsList;
  List<Coupon>? couponsList;

  @override
  void initState() {
    super.initState();
    //getList();
  }

  getList() async {
    paymentMethodsList = await apiClient.getPaymentMethodsList();
    print("paymentMethodsList:--" + paymentMethodsList.toString());
    setState(() {
      _isLoading = false;
    });
  }

// Загрузка товаров

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<PaymentMethodsList>(context).reloadPaymentMethods().then(
        (_) {
          /*setState(() {
          _isLoading = false;
        });*/
        },
      );
      Provider.of<ShippingMethodsList>(context).reloadShippingMethods().then(
        (_) {
          // setState(() {
          //   _isLoading = false;
          // });
        },
      );
      Provider.of<Coupons>(context).getCoupons().then(
        (_) {
          setState(() {
            _isLoading = false;
          });
        },
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitBuild) {
      cartListModel = widget.cartListModel;
      listPaymentMethodsList = Provider.of<PaymentMethodsList>(context).items;
      shippingMethodsList = Provider.of<ShippingMethodsList>(context).items;
      couponsList = Provider.of<Coupons>(context).coupons;
      listCouponNames.clear();
      for (Coupon getCoupon in couponsList!) {
        listCouponNames.add(getCoupon.code);
      }
      total = cartListModel.totals!.total!;
      _isInitBuild = false;
    }
    print("paymentMethodsList:--" + paymentMethodsList.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                //padding: const EdgeInsets.only(bottom: 100),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, i) =>
                    PlaceOrderItemWidget(order: cartListModel, total: total),
              ),
              // Text('$id'),
              /*SizedBox(
                height: 500,
                child: _textField(),
              ),*/
              const SizedBox(height: 25,),
              if(listCouponNames.isNotEmpty)
                const Text("Coupon Code", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              if(listCouponNames.isNotEmpty)
                const SizedBox(height: 10,),
              if (listCouponNames.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: applyCoupon(couponsList!)),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              const Text(
                "Payment Methods",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              _isLoading
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listPaymentMethodsList!.length,
                      itemBuilder: (context, int index) {
                        var tt = listPaymentMethodsList![index];
                        if (tt.id == "cod") {
                          return RadioListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: Text(
                                tt.title.toString(),
                                style: const TextStyle(fontSize: 14),
                              ),
                              value: tt,
                              groupValue: _rampResult,
                              onChanged: (dynamic value) {
                                setState(() {
                                  _rampResult = value;
                                  paymentMethod = value.id.toString();
                                  paymentMethodTitle = value.title.toString();
                                });
                              });
                        } else {
                          return Container();
                        }
                      }),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Shipping Methods",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              _isLoading
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: shippingMethodsList!.length,
                      itemBuilder: (context, int index) {
                        var tt = shippingMethodsList![index];
                        return RadioListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(
                              tt.title.toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                            value: tt,
                            groupValue: _rampResultShipping,
                            onChanged: (dynamic value) {
                              setState(() {
                                _rampResultShipping = value;
                                shippingMethodId = value.id.toString();
                                shippingMethodTitle = value.title.toString();
                              });
                            });
                      }),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Billing Address",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                child: Container(
                  //height: 150,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartListModel
                              .customer!.billingAddress!.billingFirstName! +
                          " " +
                          cartListModel
                              .customer!.billingAddress!.billingLastName!),
                      const SizedBox(height: 3),
                      if (cartListModel
                          .customer!.billingAddress!.billingCompany!.isNotEmpty)
                        Column(
                          children: [
                            Text(cartListModel
                                .customer!.billingAddress!.billingCompany!),
                            const SizedBox(height: 3),
                          ],
                        ),
                      Text(cartListModel
                          .customer!.billingAddress!.billingAddress1!),
                      const SizedBox(height: 3),
                      Text(cartListModel
                          .customer!.billingAddress!.billingAddress2!),
                      const SizedBox(height: 3),
                      Text(
                          cartListModel.customer!.billingAddress!.billingCity!),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Text(cartListModel
                              .customer!.billingAddress!.billingState!),
                          const SizedBox(width: 3),
                          Text(cartListModel
                              .customer!.billingAddress!.billingCountry!),
                          const SizedBox(width: 3),
                          Text(cartListModel
                              .customer!.billingAddress!.billingPostcode!),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                MyProfileBillingAddressScreen.routeName,
                                arguments: cartListModel.customer);
                          },
                          child: const Text("Edit", style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Shipping Address",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                child: Container(
                  //height: 150,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartListModel
                              .customer!.shippingAddress!.shippingFirstName! +
                          " " +
                          cartListModel
                              .customer!.shippingAddress!.shippingLastName!),
                      const SizedBox(height: 3),
                      if (cartListModel.customer!.shippingAddress!
                          .shippingCompany!.isNotEmpty)
                        Column(
                          children: [
                            Text(cartListModel
                                .customer!.shippingAddress!.shippingCompany!),
                            const SizedBox(height: 3),
                          ],
                        ),
                      Text(cartListModel
                          .customer!.shippingAddress!.shippingAddress1!),
                      const SizedBox(height: 3),
                      Text(cartListModel
                          .customer!.shippingAddress!.shippingAddress2!),
                      const SizedBox(height: 3),
                      Text(cartListModel
                          .customer!.shippingAddress!.shippingCity!),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Text(cartListModel
                              .customer!.shippingAddress!.shippingState!),
                          const SizedBox(width: 3),
                          Text(cartListModel
                              .customer!.shippingAddress!.shippingCountry!),
                          const SizedBox(width: 3),
                          Text(cartListModel
                              .customer!.shippingAddress!.shippingPostcode!),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                MyProfileShippingAddressScreen.routeName,
                                arguments: cartListModel.customer);
                          },
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              isLoadingPlaceOrder
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20.0),
                          child: const CircularProgressIndicator(),
                        )
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                      child: TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(10.0),
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 45),
                      textStyle: const TextStyle(fontSize: 16.0)
                  ),
                  onPressed: () {
                    if (paymentMethod == "" || paymentMethodTitle == "") {
                      CommonUtilities.showSnackBar(
                          context, "Please select payment method");
                    } else
                    if (shippingMethodId == "" || shippingMethodTitle == "") {
                      CommonUtilities.showSnackBar(
                          context, "Please select shipping method");
                    } else {
                      createOrder(context);
                    }
                  },
                  child: const Text("Place Order"),
                ),),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  var selectedValue = "";

  Widget applyCoupon(List<Coupon> couponsList) {
    return selectedValue.isEmpty
        ? DropdownButtonHideUnderline(
      child: DropdownButton(
        // Initial Value
        //value: listCouponNames[0],
        hint: Text("Select Coupon Code"),

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: listCouponNames.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
            total = cartListModel.totals!.total!;
            updateTotal(couponsList, newValue);
          });
        },
      ),
    )
        : DropdownButtonHideUnderline(
      child: DropdownButton(
        // Initial Value
        value: selectedValue,
        hint: Text("Select Coupon Code"),

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: listCouponNames.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
            total = cartListModel.totals!.total!;
            updateTotal(couponsList, newValue);
          });
        },
      ),
    );
  }

  Future<void> createOrder(BuildContext context) async {
    setState(() {
      isLoadingPlaceOrder = true;
    });
    var line_items = [];
    WidgetsFlutterBinding.ensureInitialized();
    await PreferenceUtils.getInit();
    var user = await PreferenceUtils.getUserInfo(AppConstants.user);
    var customerId = user.id.toString();

    for (var i = 0; i < cartListModel.items!.length; i++) {
      var obj = {};
      obj["product_id"] = cartListModel.items!.elementAt(i).id;
      obj["quantity"] = cartListModel.items!.elementAt(i).quantity!.value;
      line_items.add(obj);
    }
    print("CartGroup:--" + line_items.toString());

    var shippingitems = [];
    var shippingLines = {};
    shippingLines["method_id"] = shippingMethodId;
    shippingLines["method_title"] = shippingMethodTitle;
    shippingLines["total"] = "0";
    shippingitems.add(shippingLines);

    var couponLinesItems = [];
    if(selectedValue != ""){
      var couponLines = {};
      couponLines["code"] = selectedValue;
      couponLinesItems.add(couponLines);
    }

    final orders = await apiClient.createOrder(
      customerId: customerId,
      firstName: cartListModel.customer!.billingAddress!.billingFirstName!,
      lastName: cartListModel.customer!.billingAddress!.billingLastName!,
      addressOne: cartListModel.customer!.billingAddress!.billingAddress1!,
      addressTwo: cartListModel.customer!.billingAddress!.billingAddress2!,
      city: cartListModel.customer!.billingAddress!.billingCity!,
      country: cartListModel.customer!.billingAddress!.billingCountry!,
      email: cartListModel.customer!.billingAddress!.billingEmail!,
      phone: cartListModel.customer!.billingAddress!.billingPhone!,
      postcode: cartListModel.customer!.billingAddress!.billingPostcode!,
      state: cartListModel.customer!.billingAddress!.billingState!,
      shippingFirstName: cartListModel.customer!.shippingAddress!.shippingFirstName!,
      shippingLastName: cartListModel.customer!.shippingAddress!.shippingLastName!,
      shippingAddressOne: cartListModel.customer!.shippingAddress!.shippingAddress1!,
      shippingAddressTwo: cartListModel.customer!.shippingAddress!.shippingAddress2!,
      shippingCountry: cartListModel.customer!.shippingAddress!.shippingCountry!,
      shippingState: cartListModel.customer!.shippingAddress!.shippingState!,
      shippingCity: cartListModel.customer!.shippingAddress!.shippingCity!,
      shippingPostcode: cartListModel.customer!.shippingAddress!.shippingPostcode!,
      payment_method_title: paymentMethodTitle,
      payment_method: paymentMethod,
      line_items: line_items,
      shipping_lines: shippingitems,
      couponLines: couponLinesItems,
    );

    if (orders != null ) {
      if(orders.toJson().toString().contains("order_key")){
        if(orders.id != null){
          CommonUtilities.showSnackBar(context, "Order placed successfully");
          Navigator.of(context).pushNamedAndRemoveUntil(
              ProductOverviewScreen.routeName, (Route<dynamic> route) => false,
              arguments: AppConstants.clearCart);
        }
      }else{
        CommonUtilities.showSnackBar(context, orders.message.toString());
      }
    }

    setState(() {
      isLoadingPlaceOrder = false;
    });

    print("orders:--" + orders.toString());
  }

  void updateTotal(List<Coupon> couponsList, String selectedValue) {
    for (Coupon coupon in couponsList) {
      if (selectedValue == coupon.code) {
        if (coupon.discount_type == "percent") {
          double dTotal = double.parse(total);
          double dDiscount = double.parse(coupon.amount);
          double dPercentDiscount = (dDiscount / 100);
          double calDiscount = dTotal * dPercentDiscount;
          double finalTotal = dTotal - calDiscount;
          setState(() {
            total = finalTotal.toString();
          });
        } else if (coupon.discount_type == "fixed_cart") {
          double dTotal = double.parse(total);
          double dDiscount = double.parse(coupon.amount);
          if (dTotal > dDiscount) {
            double finalTotal = dTotal - dDiscount;
            setState(() {
              total = finalTotal.toString();
            });
          } else {
            setState(() {
              total = "0";
            });
          }
        }
        break;
      }
    }
  }
}
