import 'dart:convert';
/// success : true
/// statusCode : 200
/// code : "jwt_auth_valid_credential"
/// message : "Credential is valid"
/// data : {"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd2NhcGkuYnVpbGRlcmZseS5jb20iLCJpYXQiOjE2NjM2NzI1NTQsIm5iZiI6MTY2MzY3MjU1NCwiZXhwIjoxNjY0Mjc3MzU0LCJkYXRhIjp7InVzZXIiOnsiaWQiOjEyLCJkZXZpY2UiOiIiLCJwYXNzIjoiNTYyMzFiNDI2OWM2MmUyOWJjMTE0NTM3NTc0MzJiZmYifX19.hgigdUKfpchMt4vKFCWh-fNpVUaDGa-a6fBG4cL3_gs","id":12,"email":"john.doe@example.com","nicename":"john-doe","firstName":"John","lastName":"Doe","displayName":"john.doe"}

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());
class LoginModel {
  LoginModel({
      bool? success, 
      int? statusCode, 
      String? code, 
      String? message, 
      Data? data,}){
    _success = success;
    _statusCode = statusCode;
    _code = code;
    _message = message;
    _data = data;
}

  LoginModel.fromJson(dynamic json) {
    _success = json['success'];
    _statusCode = json['statusCode'];
    _code = json['code'];
    _message = json['message'];
    print("json['data']"+json['data'].toString());
    _data = json['data'] != null && json['data'].toString() != "[]" ? Data.fromJson(json['data']) : null;
  }
  bool? _success;
  int? _statusCode;
  String? _code;
  String? _message;
  dynamic _data;

  bool? get success => _success;
  int? get statusCode => _statusCode;
  String? get code => _code;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['statusCode'] = _statusCode;
    map['code'] = _code;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd2NhcGkuYnVpbGRlcmZseS5jb20iLCJpYXQiOjE2NjM2NzI1NTQsIm5iZiI6MTY2MzY3MjU1NCwiZXhwIjoxNjY0Mjc3MzU0LCJkYXRhIjp7InVzZXIiOnsiaWQiOjEyLCJkZXZpY2UiOiIiLCJwYXNzIjoiNTYyMzFiNDI2OWM2MmUyOWJjMTE0NTM3NTc0MzJiZmYifX19.hgigdUKfpchMt4vKFCWh-fNpVUaDGa-a6fBG4cL3_gs"
/// id : 12
/// email : "john.doe@example.com"
/// nicename : "john-doe"
/// firstName : "John"
/// lastName : "Doe"
/// displayName : "john.doe"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? token, 
      int id=0,
      String? email, 
      String? nicename, 
      String? firstName, 
      String? lastName, 
      String? displayName,}){
    _token = token;
    _id = id;
    _email = email;
    _nicename = nicename;
    _firstName = firstName;
    _lastName = lastName;
    _displayName = displayName;
}

  Data.fromJson(dynamic json) {
    _token = json['token'];
    _id = json['id'];
    _email = json['email'];
    _nicename = json['nicename'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _displayName = json['displayName'];
  }
  String? _token;
  int _id=0;
  String? _email;
  String? _nicename;
  String? _firstName;
  String? _lastName;
  String? _displayName;

  String? get token => _token;
  int get id => _id;
  String? get email => _email;
  String? get nicename => _nicename;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get displayName => _displayName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['id'] = _id;
    map['email'] = _email;
    map['nicename'] = _nicename;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['displayName'] = _displayName;
    return map;
  }

}