import 'package:dio/dio.dart';

import 'injection.dart';
import 'local_storage.dart';

class DioHelper {
  Dio dio = getDio();

  Future<Map<String, dynamic>> _getHeaders(bool isAuthRequired) async {
    var storage = LocalStorage();
    var token = await storage.getToken();
    //print( "First------>${token}");
    if (isAuthRequired && token != null) {
      return {
        'Authorization': 'Bearer $token',
        // 'Content-Type': 'application/json',
      };
    } else {
      return {'Content-Type': 'application/json'};
    }
  }

  Future<Options> options(bool isAuthRequired) async {
    final headers = await _getHeaders(isAuthRequired);
    return Options(
      receiveDataWhenStatusError: true,
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: headers,
    );
  }

  /// GET API
  Future<dynamic> get({
    required String url,
    bool isAuthRequired = false,
  }) async {
    try {
      Response response = await dio.get(
        url,
        options: await options(isAuthRequired),
      );
      return response.data;
    } catch (error) {
      return null;
    }
  }

  /// POST API
  Future<dynamic> post({
    required String url,
    Object? requestBody,
    bool isAuthRequired = false,
  }) async {
    try {
      Response response;
      if (requestBody == null) {
        response = await dio.post(url, options: await options(isAuthRequired));
      } else {
        response = await dio.post(
          url,
          data: requestBody,
          options: await options(isAuthRequired),
        );
      }
      return response.data;
    } catch (error) {
      return null;
    }
  }

  /// PUT API
  Future<dynamic> put({
    required String url,
    Object? requestBody,
    bool isAuthRequired = false,
  }) async {
    try {
      Response response;
      if (requestBody == null) {
        response = await dio.put(url, options: await options(isAuthRequired));
      } else {
        response = await dio.put(
          url,
          data: requestBody,
          options: await options(isAuthRequired),
        );
      }
      return response.data;
    } catch (error) {
      return null;
    }
  }

  /// PATCH API
  Future<dynamic> patch({
    required String url,
    Object? requestBody,
    bool isAuthRequired = false,
  }) async {
    try {
      Response response;
      if (requestBody == null) {
        response = await dio.patch(url, options: await options(isAuthRequired));
      } else {
        response = await dio.patch(
          url,
          data: requestBody,
          options: await options(isAuthRequired),
        );
      }
      return response.data;
    } catch (error) {
      return null;
    }
  }

  /// DELETE API
  Future<dynamic> delete({
    required String url,
    Object? requestBody,
    bool isAuthRequired = false,
  }) async {
    try {
      Response response;
      if (requestBody == null) {
        response = await dio.delete(
          url,
          options: await options(isAuthRequired),
        );
      } else {
        response = await dio.delete(
          url,
          data: requestBody,
          options: await options(isAuthRequired),
        );
      }
      return response.data;
    } catch (error) {
      return null;
    }
  }

  /// MULTIPART API
  Future<dynamic> uploadFile({
    required String url,
    required FormData requestBody,
    bool isAuthRequired = true,
  }) async {
    try {
      final fullOptions = await options(isAuthRequired);

      if (requestBody.files.isEmpty) {
        print("FormData is empty");
        return null;
      }

      Response response = await dio.post(
        url,
        data: requestBody,
        options: fullOptions,
      );
      print("Upload response: ${response.data}");
      return response.data;
    } catch (error) {
      print("Upload file error: $error");
      return null;
    }
  }


  Future<dynamic> postForPayment({
    required String url,
    bool isAuthRequired = false,
    Object? requestBody,
    ResponseType responseType = ResponseType.json, // default to JSON
  }) async {
    final dio = getDio();

    final options = Options(
      responseType: responseType,
      headers: isAuthRequired
          ? {
        "Authorization": "Bearer ${await LocalStorage().getToken()}",
      }
          : {},
    );

    final response = await dio.post(url, data: requestBody, options: options);
    return response.data;
  }
  Future<dynamic> postVerify({
    required String url,
    Object? requestBody,
    bool isAuthRequired = false,
    bool skipErrorSnackbar = false,
  }) async {
    try {
      final opt = await options(isAuthRequired);
      opt.extra ??= {};
      opt.extra!.addAll({'skipErrorSnackbar': skipErrorSnackbar});

      Response response;
      if (requestBody == null) {
        response = await dio.post(url, options: opt);
      } else {
        response = await dio.post(url, data: requestBody, options: opt);
      }
      return response.data;
    } catch (error) {
      return null;
    }
  }

}
