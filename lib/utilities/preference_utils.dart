import 'dart:convert';
import 'package:ecommerce_app/model/LoginModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common_utilities.dart';

class PreferenceUtils {
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp(). for initializing preference
  static getInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    await init();
  }

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  static Future<bool> remove(String key) async => await _prefsInstance!.remove(key);

  static Future<bool> clear() async => await _prefsInstance!.clear();

  static String? getString(String key) {
    return _prefsInstance!.getString(key);
  }

  static Future<bool> setString(String key, String value) async {
   // var prefs = await _instance;
    return _prefsInstance!.setString(key, value);
  }

  static Future<bool> setIntValue(String key, int value) async {
    // var prefs = await _instance;
    return _prefsInstance!.setInt(key, value);
  }


  static int? getInt(String key) {
    return _prefsInstance!.getInt(key);
  }
  static Future<bool> setKeyBool(String key, bool value) async =>
      await _prefsInstance!.setBool(key, value);

  static bool? getKeyBool(String key) => _prefsInstance!.getBool(key);

  static Future<void> saveUserInfo(String key,dynamic loginModel) async {
    final dynamic user = loginModel;

    bool result = await _prefsInstance!.setString(key, jsonEncode(user));
    CommonUtilities.printMsg(result);
  }

  static Future<Data> getUserInfo(String key) async {
    Map<String, dynamic> userMap;
    Data? user;
    final String? userStr = _prefsInstance!.getString(key);
    if (userStr != null) {
      userMap = jsonDecode(userStr) as Map<String, dynamic>;

      if (userMap != null) {
        user = Data.fromJson(userMap);
        CommonUtilities.printMsg(user);
        return user;
      }
    }

    return user!;
  }

}