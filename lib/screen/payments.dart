import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/provider/orders.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utilities/app_constants.dart';
import '../utilities/preference_utils.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({Key? key}) : super(key: key);
  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  double progress = 0;
  bool isLoading = true;
  var customerId = "";

  @override
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    await PreferenceUtils.getInit();
    var user = await PreferenceUtils.getUserInfo(AppConstants.user);
    customerId = user.id.toString();
  }

  @override
  void didChangeDependencies() {
    Provider.of<Orders>(context).getOrders(customerId).then(
          (value) => setState(
            () {
              isLoading = false;
            },
          ),
        );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    color: Colors.red,
                    backgroundColor: Colors.black,
                  ),
                  Expanded(
                    child: WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl:
                          'https://sonoff.kz/checkout/order-pay/${order.orders[0].id}/?key=${order.orders[0].orderKey}&order-pay=${order.orders[0].id}',
                      onProgress: (progress) {
                        this.progress = progress / 100;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
