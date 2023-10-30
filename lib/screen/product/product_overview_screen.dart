// import 'dart:js';

import 'package:ecommerce_app/provider/cart.dart';
import 'package:ecommerce_app/provider/products.dart';
import 'package:ecommerce_app/provider/reviews.dart';
import 'package:ecommerce_app/utilities/app_constants.dart';
import 'package:ecommerce_app/utilities/arguments.dart';
import 'package:ecommerce_app/utilities/common_utilities.dart';
import 'package:ecommerce_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:ecommerce_app/screen/cart.dart';
import 'package:ecommerce_app/widget/widget.dart';

import '../../utilities/preference_utils.dart';

enum FilterOptions {
  // ignore: constant_identifier_names
  Favorites,
  // ignore: constant_identifier_names
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = '/product_overview';

  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen>
    with SingleTickerProviderStateMixin {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;
  var _isHide = false;
  var _categoryId = 0;
  final apiClient = ApiClient();
  var customerId;
  var minValue = 0, maxValue = 0;
  Icon actionIcon = const Icon(
    Icons.search,
    size: 28.0,
  );
  Widget appBarTitle = Text("Products");
  final searchTextHolder = TextEditingController();
  late AnimationController _controller;

  //final List<String> sortListData = ['Popularity','Date added','Price lowest first','Price highest first'];
  String _selectedValue = "";
  ValueNotifier<bool> newData = ValueNotifier(false);
  bool isCheckedOnSale = false;
  bool isCheckedFeatured = false;
  bool isApply = false;
  bool isChange = false;
  bool isClearFilter = false;
  late Products productsData;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    getInit();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(milliseconds: 400),
    );
  }

  getInit() async {
    await PreferenceUtils.getInit();
    var user = await PreferenceUtils.getUserInfo(AppConstants.user);
    customerId = user.id.toString();
    AppConstants.customerID = customerId;
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      /*if(ModalRoute.of(context)!.settings.arguments.toString() == AppConstants.clearCart){
        Provider.of<Cart>(context).clearCartList().then((_) {},);
      }*/
      Provider.of<Reviews>(context).loadingReviews().then(
        (_) {
          setState(() {
            _isLoading = false;
          });
        },
      );
      if (ModalRoute.of(context)!.settings.arguments != null) {
        if (ModalRoute.of(context)!.settings.arguments.toString() ==
            AppConstants.clearCart) {
          Provider.of<Cart>(context).clearCartList().then(
                (_) {},
              );
        } else {
          dynamic argue = ModalRoute.of(context)!.settings.arguments;
          _categoryId = argue.value1 as int;
          print("argue.value1:--" + argue.value2.toString());
          appBarTitle = Text(argue.value2.toString());
        }
      }

      if (_categoryId == 0) {
        Provider.of<Products>(context).reloadProduct().then(
          (_) {
            setState(() {
              _isLoading = false;
            });
          },
        );
      } else {
        Provider.of<Products>(context).reloadCategoryProduct(_categoryId).then(
          (_) {
            setState(() {
              _isLoading = false;
            });
          },
        );
      }

      Provider.of<Cart>(context).getCartList().then(
            (_) {},
          );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    productsData = Provider.of<Products>(context, listen: false);

    return WillPopScope(
        onWillPop: () async {
          if (_categoryId != 0) {
            Navigator.of(context).pop();
            await productsData.reloadProduct();
            return false;
          }
          return true;
        },
        child: Scaffold(
          key: _key,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: _categoryId != 0
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () async => {
                          Navigator.pop(context),
                          await productsData.reloadProduct(),
                        })
                : IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => _key.currentState!.openDrawer(),
                  ),
            title: appBarTitle,
            titleSpacing: 0,
            actions: <Widget>[
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 400),
                firstChild: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    IconButton(
                      icon: actionIcon,
                      onPressed: () {
                        actionIcon = const Icon(
                          Icons.search,
                          size: 24.0,
                        );
                        setState(() {
                          _isHide = false;
                          appBarTitle = Text("Products");
                        });
                        if (searchTextHolder.text.isNotEmpty) {
                          searchTextHolder.clear();
                          FocusScope.of(context).unfocus();
                          FocusManager.instance.primaryFocus?.unfocus();
                        } else {
                          searchTextHolder.clear();
                          FocusScope.of(context).unfocus();
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                        onSearchTextChanged("");
                      },
                    )
                  ],
                ),
                secondChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: actionIcon,
                          onPressed: () {
                            if (actionIcon.icon == Icons.search) {
                              actionIcon = const Icon(
                                Icons.close,
                                size: 28.0,
                              );
                              setState(() {
                                _isHide = true;
                                appBarTitle = SizedBox(
                                  height: 35,
                                  child: TextField(
                                    autocorrect: true,
                                    controller: searchTextHolder,
                                    style: const TextStyle(fontSize: 15.0),
                                    onChanged: (value) =>
                                        {onSearchTextChanged(value)},
                                    decoration: const InputDecoration(
                                      hintText: "Search Product",
                                      //prefixIcon: Icon(Icons.search),
                                      hintStyle: TextStyle(color: Colors.grey),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: -9,
                                          top: -10,
                                          right: 15),
                                      enabledBorder: OutlineInputBorder(
                                        gapPadding: 0,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50.0)),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        gapPadding: 0,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50.0)),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1),
                                      ),
                                    ),
                                  ),
                                );
                              });
                            } else {
                              actionIcon = const Icon(
                                Icons.search,
                                size: 24.0,
                              );
                              setState(() {
                                _isHide = false;
                                //appBarTitle = Text("Products");
                              });
                              /*if(searchTextHolder.text.isNotEmpty){
                          searchTextHolder.clear();
                          FocusScope.of(context).unfocus();
                          FocusManager.instance.primaryFocus?.unfocus();

                        }else{
                          searchTextHolder.clear();
                          FocusScope.of(context).unfocus();
                          FocusManager.instance.primaryFocus?.unfocus();
                        }*/
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.filter_alt_outlined,
                            size: 28.0,
                          ),
                          onPressed: () {
                            filterBottomDialog();
                          },
                        ),
                        Consumer<Cart>(
                          builder: (_, cart, child) => Badge(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.shopping_cart,
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(CartScreen.routeName);
                                },
                              ),
                              value: cart.itemCount.toString(),
                              color: Theme.of(context).focusColor),
                          // child:
                        ),
                      ],
                    ),
                  ],
                ),
                crossFadeState: _isHide
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
            ],
          ),
          drawer: const AppDrawerWidget(),
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ProductsGrid(
                  showFavs: _showOnlyFavorites,
                ),
        ));
  }

  filterBottomDialog() {
    if (!isApply) {
      clearData();
    }

    return CommonUtilities.showBottomSheetDialog(
      context,
      _controller,
      Colors.grey.shade100,
      SizedBox(
          height: MediaQuery.of(context).size.height * 0.68,
          child: Padding(
              padding: const EdgeInsets.all(25),
              child: ValueListenableBuilder(
                  valueListenable: newData,
                  builder: (context, value, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Card(
                          elevation: 1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sort",
                                  style: kNormalTextStyle(16.0, Colors.blue,
                                      AppConstants.lato, false),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                _selectedValue != ""
                                    ? DropdownButtonFormField<String>(
                                        //dropdownColor: widget.dropdownColor,
                                        isExpanded: true,
                                        items: AppConstants.sortListData
                                            .map((String dropDownStringItem) {
                                          return DropdownMenuItem<String>(
                                            value: dropDownStringItem,
                                            child: Row(
                                              children: [
                                                Text(
                                                  dropDownStringItem,
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                )
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        decoration: const InputDecoration(
                                          /* hintText: StringRoutes.country,
                            labelText: StringRoutes.country,*/
                                          fillColor: Colors.transparent,
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.only(
                                              left: 15,
                                              bottom: -3,
                                              top: -3,
                                              right: 15),
                                        ),
                                        onChanged: (value) =>
                                            _onSelectedValue(value!),
                                        value: _selectedValue,
                                      )
                                    : DropdownButtonFormField<String>(
                                        //dropdownColor: widget.dropdownColor,
                                        isExpanded: true,
                                        items: AppConstants.sortListData
                                            .map((String dropDownStringItem) {
                                          return DropdownMenuItem<String>(
                                            value: dropDownStringItem,
                                            child: Row(
                                              children: [
                                                Text(
                                                  dropDownStringItem,
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                )
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        decoration: const InputDecoration(
                                          hintText: "Select sorting methods",
                                          fillColor: Colors.transparent,
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.only(
                                              left: 15,
                                              bottom: -3,
                                              top: -3,
                                              right: 15),
                                        ),
                                        onChanged: (value) =>
                                            _onSelectedValue(value!),
                                      )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Card(
                          elevation: 1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Filter",
                                  style: kNormalTextStyle(16.0, Colors.blue,
                                      AppConstants.lato, false),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                        child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      initialValue: minValue != 0
                                          ? minValue.toString()
                                          : null,
                                      onChanged: (dynamic value) {
                                        if (value?.isEmpty) {
                                          minValue = 0;
                                        } else {
                                          minValue = int.parse(value?.trim());
                                        }

                                        setState(() {
                                          isChange = true;
                                        });
                                        newData.value = !newData.value;
                                      },
                                      /*validator: (String? value) {
                                      return (value?.isEmpty ?? true)
                                          ? "Please enter phone number"
                                          : null;
                                    },*/
                                      decoration: const InputDecoration(
                                        labelText: 'Min',
                                        hintText: 'Min',
                                        contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: -5,
                                            top: -5,
                                            right: 15),
                                        border: OutlineInputBorder(),
                                      ),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                      child: Divider(
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        initialValue: maxValue != 0
                                            ? maxValue.toString()
                                            : null,
                                        onChanged: (dynamic value) {
                                          if (value?.isEmpty) {
                                            maxValue = 0;
                                          } else {
                                            maxValue = int.parse(value?.trim());
                                          }

                                          setState(() {
                                            isChange = true;
                                          });
                                          newData.value = !newData.value;
                                        },
                                        /*validator: (String? value) {
                                        return (value?.isEmpty ?? true)
                                            ? "Please enter phone number"
                                            : null;
                                      },*/
                                        decoration: const InputDecoration(
                                          labelText: 'Max',
                                          hintText: 'Max',
                                          contentPadding: EdgeInsets.only(
                                              left: 15,
                                              bottom: -5,
                                              top: -5,
                                              right: 15),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text(
                                          "On Sale",
                                          style: kNormalTextStyle(13.0, kGray,
                                              AppConstants.lato, false),
                                        ),
                                        //    <-- label
                                        value: isCheckedOnSale,
                                        activeColor: kBlueThemeColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        contentPadding: const EdgeInsets.all(0),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        onChanged: (newValue) {
                                          setState(() {
                                            isCheckedOnSale = newValue!;
                                          });
                                          newData.value = !newData.value;
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text(
                                          "Featured",
                                          style: kNormalTextStyle(13.0, kGray,
                                              AppConstants.lato, false),
                                        ),
                                        //    <-- label
                                        value: isCheckedFeatured,
                                        activeColor: kBlueThemeColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        contentPadding: const EdgeInsets.all(0),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        onChanged: (newValue) {
                                          setState(
                                            () {
                                              isCheckedFeatured = newValue!;
                                            },
                                          );
                                          newData.value = !newData.value;
                                        },
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (isChange) {
                              setState(() {
                                clearData();
                                isClearFilter = true;
                              });
                              newData.value = !newData.value;
                            }
                          },
                          child: Text(
                            "Clear Filter",
                            style: kNormalTextStyle(
                                13.0,
                                isChange ? kGreenThemeColor : kGray,
                                AppConstants.lato,
                                false),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        bottomBar()
                      ],
                    );
                  }))),
    );
  }

  Widget bottomBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: GestureDetector(
          onTap: () {
            clearData();
            Navigator.pop(context);
          },
          child: Container(
            height: 42,
            margin: const EdgeInsets.fromLTRB(0, 20, 10, 15),
            padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              //color: kGrayColor,
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Text(
              "Cancel",
              style: kNormalTextStyle(14.0, kGray, AppConstants.lato, false),
              textAlign: TextAlign.center,
            ),
          ),
        )),
        Expanded(
            child: Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 15),
          child: ElevatedButton(
            child: const Text("Apply"),
            style: k14SmallButtonStyle,
            onPressed: _counterButtonPress(),
          ),
        ))
      ],
    );
  }

  _counterButtonPress() {
    if (!isChange && !isClearFilter) {
      return null;
    } else {
      return () async {
        isApply = true;
        isClearFilter = false;

        if (!isCheckedOnSale && !isCheckedFeatured) {
          await productsData.filterProduct(
              _selectedValue, false, false, minValue, maxValue);
        } else {
          if (isCheckedOnSale) {
            await productsData.filterProduct(
                _selectedValue, true, false, minValue, maxValue);
          } else {
            await productsData.filterProduct(
                _selectedValue, false, false, minValue, maxValue);
          }

          if (isCheckedFeatured) {
            await productsData.filterProduct(
                _selectedValue, false, true, minValue, maxValue);
          } else {
            await productsData.filterProduct(
                _selectedValue, false, false, minValue, maxValue);
          }
        }

        Navigator.pop(context);
      };
    }
  }

  void _onSelectedValue(String value) {
    if (!mounted) return;
    setState(() {
      _selectedValue = value;
      isChange = true;
    });
    newData.value = !newData.value;
  }

  onSearchTextChanged(String text) async {
    setState(() {
      _isLoading = true;
    });

    if (text.isEmpty) {
      await productsData.searchProduct("");
      setState(() {
        _isLoading = false;
      });
    } else {
      await productsData.searchProduct(text);
      setState(() {
        _isLoading = false;
      });
    }
  }

  clearData() {
    minValue = 0;
    maxValue = 0;
    isApply = false;
    isChange = false;
    _selectedValue = "";
    isCheckedOnSale = false;
    isCheckedFeatured = false;
  }
}
