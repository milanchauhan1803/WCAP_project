import 'package:ecommerce_app/provider/categories.dart';
import 'package:ecommerce_app/widget/category_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = '/categories';

  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Categories>(context).reloadCategory().then(
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
    final categoriesData = Provider.of<Categories>(context);
    final categories = categoriesData.items;
    return Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, i) => ChangeNotifierProvider.value(
                    value: categories[i],
                    child: const CategoryItem(),
                  ),
                ),
              ));
  }
}
