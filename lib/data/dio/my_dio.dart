// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

part "interceptors.dart";

enum RequestType{
  GET,
  POST,
  PUT,
  DELETE,
  PATCH,
}

enum APIVersion{
  V1,
  V2,
}

class MyDio{
  final Dio _dio = Dio();

  MyDio(){
    _dio.interceptors.add(CustomInterceptors());
  }

  Future<Map<String, dynamic>> request({
    required RequestType requestType,
    required String path,
    bool requiresAuth = true,
    bool requiresDefaultParams = true,
    String? port,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,}) async{
    try {
      // if(requiresAuth) add token
      Response<dynamic> response;
      switch (requestType) {
        case RequestType.GET:
          response = await _dio.get(path,
            queryParameters: queryParameters
          );
          break;
        case RequestType.POST:
          response = await _dio.get(path, data: data);
          break;
        case RequestType.PATCH:
          response = await _dio.get(path, data: data);
          break;
        case RequestType.DELETE:
          response = await _dio.delete(path);
          break;
        case RequestType.PUT:
          response = await _dio.put(path, data: data);
          break;
        default:
          throw "Request type not found";
      }
      return (response.data is String) ? jsonDecode(response.data) : response.data;

    } on DioException catch (e) {
      if(kDebugMode){
        print(e.message);
      }
      return Future.error({"message": e.message, "code" : e.response?.statusCode});
    }
  }
}














