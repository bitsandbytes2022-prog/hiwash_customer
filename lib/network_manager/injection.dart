import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hiwash_customer/featuers/auth/auth_controller/auth_controller.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/network_manager/dio_helper.dart';
import 'package:hiwash_customer/network_manager/utils/print_value.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/widgets/components/app_snack_bar.dart';

import '../featuers/notification/controller/notification_controller.dart';
import '../featuers/rewads/controller.dart';
import 'api_constant.dart';
import 'local_storage.dart';

Dio getDio() {
  Dio dio = Dio();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, handler) {
        String apiEndPoint = options.path
            .split('/')
            .last;
        printValue(tag: 'API URL:', '${options.uri}');
        printValue(tag: 'HEADER:$apiEndPoint-->', options.headers);

        try {
          printValue(
            tag: 'REQUEST BODY:$apiEndPoint---onRequest--->',
            jsonEncode(options.data),
          );
        } catch (e) {
          printValue(
            tag: 'REQUEST BODY ERROR:$apiEndPoint---onRequest--->',
            e.toString(),
          );
        }

        return handler.next(options);
      },

      onResponse: (Response response, ResponseInterceptorHandler handler) {
        printValue(
          tag: 'API RESPONSE: ${response.requestOptions.path}',
          response.data,
        );
        return handler.next(response);
      },

      onError: (DioException e, handler) async {
        print(e.requestOptions.method);
        print("---------------------->${e.requestOptions.uri}");
        print(e.requestOptions.data);
        printValue(
          tag: 'STATUS CODE:${e.response?.statusCode}--onError STATUS CODE--->',
          "${e.response?.statusCode ?? ""}",
        );
        printValue(
          tag: 'ERROR DATA :--onError ERROR DATA--->',
          e.response?.data ?? "",
        );
        print("999----->${e.message}");
        if (e.response?.statusCode == 400) {
          appSnackBar(
            message:
            e.response?.data["error"]["message"] ??
                StringConstant.kSomethingWentWrong.tr.toString(),
          );
        }
         else if (e.response?.statusCode == 401) {
        /*  appSnackBar(
            message:
            e.response?.data["error"]["message"] ??
                StringConstant.kSomethingWentWrong.tr.toString(),
          );*/
          AuthController authController=Get.find();
          authController.refreshToken();


        }




        else if (e.response?.statusCode == 404) {
          appSnackBar(
            message:
            e.response?.data["error"]["message"] ??
                StringConstant.kSomethingWentWrong.tr.toString(),
          );
        } else if (e.response?.statusCode == 500) {
          //print("object${e.response?.data.toString()}");
          appSnackBar(
            message:
            e.response?.data["error"]["message"] ??
                StringConstant.kSomethingWentWrong.tr.toString(),
          );
        }

        return handler.next(e);
      },


    ),
  );
  return dio;
}

