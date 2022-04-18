import 'dart:async';
import 'dart:developer';
import 'package:coin_converter/dio/cc_json_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const _baseUrl = "api.coincap.io";

class CCService {
  var _dio = Dio();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  CCService() {
    _dio.options.baseUrl = "https://$_baseUrl/v2/";

    //TODO: Remove unnecessary prints
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          print("Request: 1");
          handler.next(request);
        },
        onResponse: (response, handler) {
          print("Response: 1");
          handler.next(response);
        },
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          print("Request: 2");
          handler.next(request);
        },
        onResponse: (response, handler) {
          print("Response: 2");
          handler.next(response);
        },
      ),
    );

    _dio.interceptors.add(LogInterceptor());
    _dio.interceptors.add(
      InterceptorsWrapper(onError: (error, handler) async {
        var scaffoldMessenger = scaffoldMessengerKey.currentState;
        if (scaffoldMessenger != null && scaffoldMessenger.mounted == true) {
          var snackbarResult = scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text(toString() + " Network error!"),
              action: SnackBarAction(
                label: 'RETRY',
                onPressed: () {},
              ),
              duration: Duration(seconds: 10),
            ),
          );
          var reason = await snackbarResult.closed;
        }
        handler.next(error);
      }),
    );
  }

  Future<CCAssetsResponse> getCCAssets() async {
    var response = await _dio.get(
      "assets"
    );
    log(response.data);
    return CCAssetsResponse.fromJson(response.data);
  }

  Future<CCRatesResponse> getCCRates() async {
    var response = await _dio.get(
      "rates"
    );
    return CCRatesResponse.fromJson(response.data);
  }
}