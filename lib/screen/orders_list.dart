import 'package:ecommerce_app/provider/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/order.dart';
import '../utilities/app_constants.dart';
import '../utilities/common_utilities.dart';
import '../utilities/search_filter_view.dart';
import '../widget/choicechip_view.dart';
import '../widget/order_item.dart';
import 'package:flutter/src/widgets/basic.dart' as stateful_builder;

class OrdersListScreen extends StatefulWidget {
  static const routeName = '/orders_list';

  const OrdersListScreen({Key? key}) : super(key: key);

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen>
    with SingleTickerProviderStateMixin {
  var _isInit = true;
  var _isLoading = false;
  var customerId;
  var isApplied = false;
  late AnimationController _controller;
  List<String> selectedChoices = [];
  List<String> selectedOrderTimeChoices = [];
  ValueNotifier<bool> newData = ValueNotifier(false);
  List<Order> orders = [];
  List<Order> filterOrders = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(milliseconds: 400),
    );
  }

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
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Orders>(context).getOrders(AppConstants.customerID).then(
        (_) {
          setState(() {
            _isLoading = false;
            final ordersData = Provider.of<Orders>(context, listen: false);
            orders = ordersData.orders;
            filterOrders = ordersData.orders;
          });
        },
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Orders",
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SearchFilterView(
                callback: (valu1, valu2) {
                  if (valu1 == 1 && valu2 == 1) {
                    if (!isApplied) {
                      selectedChoices.clear();
                      selectedOrderTimeChoices.clear();
                    }
                    filterBottomDialog();
                  } else {
                    // if(valu1 != ""){
                    //   orderslistMdl.search = valu1;
                    //   orderslistMdl.wsOrderList();
                    // }else{
                    //   orderslistMdl.search = "";
                    //   orderslistMdl.wsOrderList();
                    // }
                  }
                },
              ),
            ),
          ],
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : filterOrders.length == 0
                ? Center(
                    child: Text(
                    "No Orders Found!",
                    style: TextStyle(fontSize: 18),
                  ))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: filterOrders.length,
                    itemBuilder: (context, i) => ChangeNotifierProvider.value(
                      value: filterOrders[i],
                      child: OrderItem(filterOrders[i]),
                    ),
                  ));
  }

  Future filterBottomDialog() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        transitionAnimationController: _controller,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            // <-- SEE HERE
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return stateful_builder.StatefulBuilder(
            builder: (BuildContext context, setState) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Padding(
                      padding: const EdgeInsets.all(0), child: sortCardData()));
            },
          );
        });
  }

  Widget sortCardData() {
    return ValueListenableBuilder(
        valueListenable: newData,
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Filters",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff222222),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 1.0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedChoices.clear();
                                selectedOrderTimeChoices.clear();
                              });
                              newData.value = !newData.value;
                            },
                            child: Text(
                              "Clear Filter",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 13.0,
                                  color: selectedChoices.isNotEmpty ||
                                          selectedOrderTimeChoices.isNotEmpty
                                      ? Color(0xff2AAB34)
                                      : Color(0x7E000000)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text("Order Status",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff222222),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                        child: Wrap(
                      spacing: 10,
                      children: List<Widget>.generate(
                        AppConstants.orderFilterData.length,
                        (int index) {
                          return ChoiceChipView(
                              list: AppConstants.orderFilterData,
                              selectedChoices: selectedChoices,
                              index: index,
                              callback: (value1) {
                                if (value1 == 0) {
                                  selectedChoices.remove(AppConstants
                                      .orderFilterData
                                      .elementAt(index)['name']);
                                } else {
                                  //selectedOrderTimeChoices.clear();
                                  selectedChoices.add(AppConstants
                                      .orderFilterData
                                      .elementAt(index)['name']);
                                }
                                CommonUtilities.printMsg(
                                    "filter1:-" + selectedChoices.toString());
                                newData.value = !newData.value;
                              });
                        },
                      ).toList(),
                    )),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Order Time",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff222222),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                        child: Wrap(
                      spacing: 15,
                      children: List<Widget>.generate(
                        AppConstants.orderFilterTimeData.length,
                        (int index) {
                          return ChoiceChipView(
                              list: AppConstants.orderFilterTimeData,
                              selectedChoices: selectedOrderTimeChoices,
                              index: index,
                              callback: (value1) {
                                if (value1 == 0) {
                                  selectedOrderTimeChoices.remove(AppConstants
                                      .orderFilterTimeData
                                      .elementAt(index)['name']);
                                } else {
                                  selectedOrderTimeChoices.clear();
                                  selectedOrderTimeChoices.add(AppConstants
                                      .orderFilterTimeData
                                      .elementAt(index)['name']);
                                }
                                CommonUtilities.printMsg("filter2:-" +
                                    selectedOrderTimeChoices.toString());
                                newData.value = !newData.value;
                              });
                        },
                      ).toList(),
                    ))
                  ],
                ),
              ),
              bottomBar()
            ],
          );
        });
  }

  Widget bottomBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: GestureDetector(
          onTap: () {
            //isApplied = false;
            Navigator.pop(context);
          },
          child: Container(
            height: 42,
            margin: const EdgeInsets.fromLTRB(25, 20, 10, 15),
            padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              //color: kGrayColor,
              border: Border.all(color: Colors.black, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
            child: const Text(
              "Cancel",
              style: TextStyle(
                  fontSize: 14.0, fontFamily: 'Inter', color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        )),
        Expanded(
            child: Container(
          margin: const EdgeInsets.fromLTRB(10, 20, 25, 15),
          child: ElevatedButton(
            child: const Text("Apply"),
            style: TextButton.styleFrom(
                padding: const EdgeInsets.all(13.0),
                primary: Colors.white,
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 35),
                textStyle: const TextStyle(
                  fontSize: 14.0,
                )),
            onPressed: () {
              isApplied = true;
              /* List<String> finalSelectedChoices = [];
                  for(int i=0;i<selectedChoices.length;i++){
                    finalSelectedChoices.add('"'+selectedChoices.elementAt(i)+'"');
                  }*/
              Navigator.pop(context);
              setState(() {
                filterOrders.clear();

                if (selectedChoices.isNotEmpty ||
                    selectedOrderTimeChoices.isNotEmpty) {
                  int selectedDaysDiff = 0;
                  if (selectedOrderTimeChoices.isNotEmpty) {
                    if (selectedOrderTimeChoices.elementAt(0) ==
                        AppConstants.anyTime) {
                      selectedDaysDiff = 0;
                    } else if (selectedOrderTimeChoices.elementAt(0) ==
                        AppConstants.last30Days) {
                      selectedDaysDiff = 30;
                    } else if (selectedOrderTimeChoices.elementAt(0) ==
                        AppConstants.last6Months) {
                      selectedDaysDiff = 180;
                    } else {
                      selectedDaysDiff = 365;
                    }
                  }

                  for (Order getOrder in orders) {
                    final orderDate = DateTime.parse(getOrder.createdDate);
                    final currentDate = DateTime.now();
                    final difference = daysBetween(orderDate, currentDate);

                    if (selectedDaysDiff == 0) {
                      if (selectedChoices.isEmpty || selectedChoices.contains(getOrder.status)) {
                        filterOrders.add(getOrder);
                      }
                    } else {
                      if ((selectedChoices.isEmpty || selectedChoices.contains(getOrder.status)) &&
                          difference <= selectedDaysDiff) {
                        filterOrders.add(getOrder);
                      }
                    }
                  }
                } else {
                  filterOrders.addAll(orders);
                }
              });

              CommonUtilities.printMsg(
                  "finalSelectedChoices:--" + selectedChoices.toString());
            },
          ),
        ))
      ],
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
