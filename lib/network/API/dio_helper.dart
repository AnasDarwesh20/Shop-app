import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
    String token,
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/jason',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    @required String url,
    @required Map<String, dynamic> data,
    dynamic token,
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/jason',
    };
    return dio.post(
      url,
      data: data,
      options: Options(contentType: 'application/json'),
    );
  }

  static Future<Response> putData({
    @required String url,
    @required Map<String, dynamic> data,
    dynamic token,
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/jason',
    };
    return dio.put(
      url,
      data: data,
      options: Options(contentType: 'application/json'),
    );
  }
}
