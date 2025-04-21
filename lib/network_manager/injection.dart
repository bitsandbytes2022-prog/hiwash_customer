import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hiwash_customer/network_manager/utils/print_value.dart';
import 'package:hiwash_customer/route/route_strings.dart';

import 'local_storage.dart';

Dio getDio () {
  Dio dio = Dio();

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (RequestOptions options, handler) {
      String apiEndPoint = options.path.split('/').last;
      printValue(tag: 'API URL:', '${options.uri}');
      printValue(tag: 'HEADER:$apiEndPoint', options.headers);


      try {
        printValue(tag: 'REQUEST BODY:$apiEndPoint ', jsonEncode(options.data));
      } catch (e) {
        printValue(tag: 'REQUEST BODY ERROR: ', e.toString());
      }

      return handler.next(options);
    },

    onResponse: (Response response, ResponseInterceptorHandler handler) {
      printValue(tag: 'API RESPONSE:', response.data);
      return handler.next(response);
    },

    onError: (DioException e, handler) async {
      printValue(tag: 'STATUS CODE:' ,"${e.response?.statusCode??""}");
      printValue(tag: 'ERROR DATA :' ,e.response?.data??"");

      if (e.response?.statusCode == 401) {

        Get.snackbar("Error", (e.response?.data["error"]["message"] ?? "Something went wrong").toString(),
            colorText: Colors.white,
            backgroundColor: Colors.red
        );
       // final storage = LocalStorage();

     //   await storage.removeToken();
        Get.offAllNamed(RouteStrings.welcomeScreen);
      } else if (e.response?.statusCode == 404) {
        // handle 404 error
        Get.snackbar("Error", (e.response?.data["error"]["message"] ?? "Something went wrong").toString(),
            colorText: Colors.white,
            backgroundColor: Colors.red
        );
      }
      return handler.next(e);
    },
  ));
  return dio;

}


