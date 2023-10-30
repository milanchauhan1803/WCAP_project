import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonUtilities{

  static navigatorPop(BuildContext context){
    Navigator.pop(context);
  }

  static navigatorPopUntil(BuildContext context,dynamic value){
    Navigator.of(context).popUntil((route){
      return route.settings.name == value;
    });
  }

  static navigatorPopAndPush(BuildContext context,dynamic value){
    Navigator.of(context).popAndPushNamed(value);
  }

  static navigatorPushRemoveUntil(BuildContext context,dynamic value){
    Navigator.of(context).pushNamedAndRemoveUntil(value, (Route<dynamic> route) => false);
  }

  static navigatorPushWithArguments(BuildContext context,dynamic value,dynamic arguments){
    Navigator.pushNamed(context,
      value,
      arguments: arguments,
    );
  }

  static printMsg(dynamic msg){
    if (kDebugMode) {
      print(msg);
    }
  }

  static showUtilDialog(BuildContext context,dynamic value){
    showGeneralDialog(barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: value,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 350),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return value;
        });
  }

  static showBottomSheetDialog(BuildContext context,AnimationController _controller,dynamic color,dynamic value){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        transitionAnimationController: _controller,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only( // <-- SEE HERE
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        backgroundColor: color,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return value;
          },);
        });
  }

  static showNormalDialod(BuildContext context,dynamic value){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return value;
        }).then((value) => value);
  }

  static showSnackBar(BuildContext context,dynamic msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  static showToastErrorMessage(BuildContext context,dynamic msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 13.0
    );
  }

  static void changeSystemStatusColor(Color color){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color, //i like transaparent :-)
      systemNavigationBarColor: color, // navigation bar color
      statusBarIconBrightness: Brightness.light, // status bar icons' color
      systemNavigationBarIconBrightness:Brightness.light,
    ));
  }

  static void changeSystemStatusColorTransparent(Color color){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //i like transaparent :-)
      systemNavigationBarColor: color, // navigation bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:Brightness.dark,
      //statusBarBrightness: Brightness.light,//navigation bar icons' color
    ));
  }

}