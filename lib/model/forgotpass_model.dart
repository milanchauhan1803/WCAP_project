import 'dart:convert';
/// code : "200"
/// msg : "Password reset link has been sent to your registered email"

ForgotpassModel ForgotpassModelFromJson(String str) => ForgotpassModel.fromJson(json.decode(str));
String ForgotpassModelToJson(ForgotpassModel data) => json.encode(data.toJson());
class ForgotpassModel {
  ForgotpassModel({
      String? code, 
      String? msg,}){
    _code = code;
    _msg = msg;
}

  ForgotpassModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
  }
  String? _code;
  String? _msg;

  String? get code => _code;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    return map;
  }

}