import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../utilities/app_constants.dart';
import '../utilities/preference_utils.dart';
import 'app_exception.dart';
import 'base_api_service.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getResponse(String url) async {
    dynamic responseJson;
     String? token = PreferenceUtils.getString(AppConstants.token);
    //String? token = "U2FsdGVkX18M8Q9JwbL7Nx82AlSJ82nl4sKeIz77yps=";

    //  print("TOKEN:--" + token.toString());

    try {
      final response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: '$token',
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw Fluttertoast.showToast(
          msg: "No internet connection", backgroundColor: Colors.grey);
    }
    return responseJson;
  }

  @override
  Future postResponse(String url, Map<String, Object> JsonBody) async {
    dynamic responseJson;
    PreferenceUtils.getInit();
    String? token = PreferenceUtils.getString(AppConstants.token);
    print("TOKEN:--" + token.toString());
    try {
      print("json" + JsonBody.toString());
      final response =
          await http.post(Uri.parse(url), body: jsonEncode(JsonBody), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "$token",
      });
      print("statusCode " + response.statusCode.toString());
      responseJson = returnResponse(response);
    } on SocketException {
      throw Fluttertoast.showToast(
          msg: "No internet connection", backgroundColor: Colors.grey);
    }
    return responseJson;
  }

  @override
  Future deleteResponse(String url) async {
    dynamic responseJson;
    String? token = PreferenceUtils.getString(AppConstants.token);
    print("TOKEN:--" + token.toString());

    try {
      final response = await http.delete(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: '$token',
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw Fluttertoast.showToast(
          msg: "No internet connection", backgroundColor: Colors.grey);
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    print("RESPONSE:--" + response.toString());
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        //print("JSONRESPONSE 200 :--" + responseJson.toString());
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
      //  print("JSONRESPONSE:--" + responseJson.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        //print("JSONRESPONSE:--" + responseJson.toString());
        return responseJson;
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }

  @override
  Future postMultipartFileResponse(String url, String filepath) async {
    dynamic responseJson;
    String? token = PreferenceUtils.getString(AppConstants.token);
    //String? token = "U2FsdGVkX18UIcrbKpwtqflakwu6npX2qKHy7xartKw=";
    if (kDebugMode) {
      print("TOKEN:--" + token.toString());
    }

    try {
      if (kDebugMode) {
        print(filepath);
      }
      /*final response = await http.post(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader : '$token',
          });*/

      var response = http.MultipartRequest('POST', Uri.parse(url),);
      response.files.add(await http.MultipartFile.fromPath('attachment', filepath));
      var res = await response.send();
      //return res.reasonPhrase;

      if (kDebugMode) {
        print(res.statusCode);
        print("JSONRESPONSE:--"+responseJson.toString());
      }

      final respStr = await res.stream.bytesToString();
      responseJson = jsonDecode(respStr);

    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

}
