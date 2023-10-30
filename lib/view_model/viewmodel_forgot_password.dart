import 'package:ecommerce_app/model/forgotpass_model.dart';
import 'package:ecommerce_app/network_services/base_api_service.dart';
import 'package:ecommerce_app/network_services/network_api_service.dart';
import 'package:ecommerce_app/network_services/response/api_response.dart';
import 'package:flutter/material.dart';

class ViewModelForgotPassword with ChangeNotifier {
  final BaseApiService _apiService = NetworkApiService();

  ApiResponse<ForgotpassModel> forgotPassApi = ApiResponse.none();

  void _setGetProfileApiResponse(ApiResponse<ForgotpassModel> response) {
    forgotPassApi = response;
    notifyListeners();
  }

  Future<void> forgotPasswordAPICall(String apiUrl) async {
    print(apiUrl);
    dynamic _response = await _apiService.getResponse(apiUrl);
    try {
      final jsonData = ForgotpassModel.fromJson(_response);
      _setGetProfileApiResponse(ApiResponse.completed(jsonData));
      print("Response code " + jsonData.toJson().toString());

    } catch (e) {
      print("Error Response code " + e.toString());
      _setGetProfileApiResponse(ApiResponse.error(e.toString()));
    }
  }
}
