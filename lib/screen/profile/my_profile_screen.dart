import 'package:ecommerce_app/screen/profile/my_profile_basic_info_screen.dart';
import 'package:ecommerce_app/screen/profile/my_profile_billing_address_screen.dart';
import 'package:ecommerce_app/screen/profile/my_profile_shipping_address_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/customers.dart';
import '../../utilities/app_constants.dart';
import '../../utilities/preference_utils.dart';

class MyProfileScreen extends StatefulWidget {
  static const routeName = '/my_profile';
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  var _isInit = true;
  var _isLoading = false;
  var customerData;
  var customerId;

  /*@override
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    await PreferenceUtils.getInit();
    var user = await PreferenceUtils.getUserInfo(AppConstants.user);
    customerId = user.id.toString();
  }*/

  @override
  void didChangeDependencies() {
    print("AppConstants.customerID:---"+AppConstants.customerID);

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Customers>(context).reloadCustomer(AppConstants.customerID).then(
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
    if(!_isLoading){
      final customersData = Provider.of<Customers>(context);
      customerData = customersData.item;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
        body:
        _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text("Basic Details", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    const Text("Basic info about you", style: TextStyle(fontSize: 18, color: Colors.grey),),
                    const SizedBox(height: 15,),
                    Card(
                      elevation: 3,
                      child: Container(
                        //height: 120,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(customerData.first_name + " " + customerData.last_name),
                            const SizedBox(height: 3),
                            Text("Email: " + customerData.email),
                            const SizedBox(height: 3,),
                            Text("Username: " + customerData.username),
                            const SizedBox(height: 3,),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pushNamed(MyProfileBasicInfoScreen.routeName, arguments: customerData);
                                },
                                child: const Text("Edit", style: TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.bold),),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text("Billing Address", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    const Text("Your billing address", style: TextStyle(fontSize: 18, color: Colors.grey),),
                    const SizedBox(height: 15,),
                    Card(
                      elevation: 3,
                      child: Container(
                        // /height: 150,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(customerData.billing.firstName + " " + customerData.last_name),
                            const SizedBox(height: 3),
                            /*if(customerData.billing.company.isNotEmpty)
                              Column(
                                children: [
                                  Text(customerData.billing.company),
                                  const SizedBox(height: 3),
                                ],
                              ),*/
                            Text(customerData.billing.address1),
                            const SizedBox(height: 3),
                            Text(customerData.billing.address2),
                            const SizedBox(height: 3),
                            Text(customerData.billing.city),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Text(customerData.billing.state),
                                const SizedBox(width: 3),
                                Text(customerData.billing.country),
                                const SizedBox(width: 3),
                                Text(customerData.billing.postcode),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pushNamed(MyProfileBillingAddressScreen.routeName, arguments: customerData);
                                },
                                child: const Text("Edit", style: TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.bold),),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text("Shipping Address", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    const Text("Your shipping address", style: TextStyle(fontSize: 18, color: Colors.grey),),
                    const SizedBox(height: 15,),
                    Card(
                      elevation: 3,
                      child: Container(
                        //height: 150,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(customerData.shipping.firstName + " " + customerData.last_name),
                            const SizedBox(height: 3),
                           /* if(customerData.shipping.company.isNotEmpty)
                              Column(
                                children: [
                                  Text(customerData.shipping.company),
                                  const SizedBox(height: 3),
                                ],
                              ),*/
                            Text(customerData.shipping.address1),
                            const SizedBox(height: 3),
                            Text(customerData.shipping.address2),
                            const SizedBox(height: 3),
                            Text(customerData.shipping.city),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Text(customerData.shipping.state),
                                const SizedBox(width: 3),
                                Text(customerData.shipping.country),
                                const SizedBox(width: 3),
                                Text(customerData.shipping.postcode),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pushNamed(MyProfileShippingAddressScreen.routeName, arguments: customerData);
                                },
                                child: const Text("Edit", style: TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.bold),),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        );
  }
}
