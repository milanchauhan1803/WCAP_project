import 'package:flutter/material.dart';
import 'callback.dart';

class SearchFilterView extends StatefulWidget {
  final Callback1 callback;

  const SearchFilterView({Key? key, required this.callback}) : super(key: key);

  @override
  State<SearchFilterView> createState() => _SearchFilterViewState();
}

class _SearchFilterViewState extends State<SearchFilterView> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        widget.callback(1, 1);
      },
      icon: Image.asset(
        "assets/images/fi_filter.png",
        height: 18,
        width: 18,
        color: Colors.white,
      ),
    );
  }
}
