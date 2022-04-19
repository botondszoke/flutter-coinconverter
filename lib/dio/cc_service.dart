import 'dart:async';
import 'dart:developer';
import 'package:coin_converter/dio/cc_api.dart';
import 'package:coin_converter/dio/cc_json_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const _baseUrl = "api.coincap.io";

class CCService implements CCApi {
  var _dio = Dio();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  CCService() {
    _dio.options.baseUrl = "https://$_baseUrl/v2/";
    _dio.interceptors.add(LogInterceptor());
  }

  Future<CCAssetsResponse?> getCCAssets() async {
    var response = await _dio.get(
      "assets",
      options: Options(receiveTimeout: 10000)
    );
    //log(response.data);
    if (response.statusCode != 200)
      throw Exception("Unexpected network status code.");
    try {
      return CCAssetsResponse.fromJson(response.data);
    }
    on Exception {
      throw Exception("Data parsing error.");
    }
  }

  Future<CCRatesResponse?> getCCRates() async {
    var response = await _dio.get(
      "rates",
        options: Options(receiveTimeout: 10000)
    );
    //log(response.data);
    if (response.statusCode != 200)
      throw Exception("Unexpected network status code.");
    try {
      return CCRatesResponse.fromJson(response.data);
    }
    on Exception {
      throw Exception("Data parsing error.");
    }
  }
}