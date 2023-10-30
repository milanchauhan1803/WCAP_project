import 'dart:convert';
/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9qd3QuZGV2IiwiaWF0IjoxNDM4NTcxMDUwLCJuYmYiOjE0Mzg1NzEwNTAsImV4cCI6MTQzOTE3NTg1MCwiZGF0YSI6eyJ1c2VyIjp7ImlkIjoiMSJ9fX0.YNe6AyWW4B7ZwfFE5wJ0O6qQ8QFcYizimDmBy6hCH_8"
/// user_display_name : "admin"
/// user_email : "admin@localhost.dev"
/// user_nicename : "admin"

GetAuthTokenModel getAuthTokenModelFromJson(String str) => GetAuthTokenModel.fromJson(json.decode(str));
String getAuthTokenModelToJson(GetAuthTokenModel data) => json.encode(data.toJson());
class GetAuthTokenModel {
  GetAuthTokenModel({
      String? token, 
      String? userDisplayName, 
      String? userEmail, 
      String? userNicename,}){
    _token = token;
    _userDisplayName = userDisplayName;
    _userEmail = userEmail;
    _userNicename = userNicename;
}

  GetAuthTokenModel.fromJson(dynamic json) {
    _token = json['token'];
    _userDisplayName = json['user_display_name'];
    _userEmail = json['user_email'];
    _userNicename = json['user_nicename'];
  }
  String? _token;
  String? _userDisplayName;
  String? _userEmail;
  String? _userNicename;

  String? get token => _token;
  String? get userDisplayName => _userDisplayName;
  String? get userEmail => _userEmail;
  String? get userNicename => _userNicename;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['user_display_name'] = _userDisplayName;
    map['user_email'] = _userEmail;
    map['user_nicename'] = _userNicename;
    return map;
  }

}