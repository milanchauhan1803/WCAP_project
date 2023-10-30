import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static const lato = "Lato";
  static const latoB = "Lato B";
  static const anton = "Anton";

  static const token = "TOKEN";
  static const login = "LOGIN";
  static const password = "PASSWORD";
  static const coCartLogin = "COCARTLOGIN";
  static const user = "USERINFO";
  static const customerId = "ID";

  static const currencySymbol = "\$";
  static const rs = "₹";
  static const clearCart = "CLEAR_CART";
  static const grouped = "grouped";
  static const external = "external";
  static const variable = "variable";

  static var customerID = "";

  static const channelId = "<---Add your channel ID here--->";
  static const channelName = "<---Add your channel name here--->";

  static const vapidKey = "----Add your firebase vapidkry here----";

  /*
  * Used for globally context
  * */
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const pending = "pending";
  static const processing = "processing";
  static const onhold = "on-hold";
  static const completed = "completed";
  static const cancelled = "cancelled";
  static const refunded = "refunded";
  static const failed = "failed";
  static const trash = "trash";

  static const anyTime = "Anytime";
  static const last30Days = "Last 30 days";
  static const last6Months = "Last 6 months";
  static const lastYear = "Last year";

  static const popularity = "Popularity";
  static const dateAdded = "Date added";
  static const priceLowestFirst = "Price lowest first";
  static const priceHighestFirst = "Price highest first";

  static const List<Map<String, dynamic>> orderFilterData = [
    {"id": 1, "name": AppConstants.pending},
    {"id": 2, "name": AppConstants.processing},
    {"id": 3, "name": AppConstants.onhold},
    {"id": 4, "name": AppConstants.completed},
    {"id": 5, "name": AppConstants.cancelled},
    {"id": 6, "name": AppConstants.refunded},
    {"id": 7, "name": AppConstants.failed},
    {"id": 8, "name": AppConstants.trash}
  ];

  static const List<Map<String, dynamic>> orderFilterTimeData = [
    {"id": 1, "name": AppConstants.anyTime},
    {"id": 2, "name": AppConstants.last30Days},
    {"id": 3, "name": AppConstants.last6Months},
    {"id": 4, "name": AppConstants.lastYear}
  ];

  static const List<String> sortListData = [
    AppConstants.popularity,
    AppConstants.dateAdded,
    AppConstants.priceLowestFirst,
    AppConstants.priceHighestFirst];
}