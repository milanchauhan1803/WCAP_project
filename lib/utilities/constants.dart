import 'package:flutter/material.dart';

class Constants{
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}

const kGreenThemeColor = Color(0xff2AAB34);
const kBlueThemeColor = Colors.blue;
const kPrimaryTextColor = Color(0xff222222);
const kGrayColor = Color(0xffF6F6F6);
const kGrayLineColor = Color(0xffF4F4F4);
const kOrangeColor = Color(0xffFFA941);
const kYellowRatingColor = Color(0xffFFD800);
const kDividerColor = Color(0xa3000000);
const kListDividerColor = Color(0xffECECEC);
const kFormTextFieldColor = Color(0xff000000);
const kGray = Color(0x7E000000);
const kBlue = Color(0xff355CEC);

kNormalTextStyle(dynamic font,dynamic color,dynamic fontFamily,dynamic isBold){
  return TextStyle(
      fontFamily: fontFamily,
      fontSize: font,
      color: color,
      fontWeight: isBold ? FontWeight.bold : null
  );
}

final k14SmallButtonStyle = TextButton.styleFrom(
    padding: const EdgeInsets.all(13.0),
    /*primary: Colors.white,
    backgroundColor: kBlueThemeColor,*/
    minimumSize: const Size(double.infinity,35),
    textStyle: const TextStyle(
      fontSize: 14.0,
      fontFamily: 'Inter',
    )
);