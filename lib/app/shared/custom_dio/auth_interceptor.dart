import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../auth/auth_controller.dart';
import 'custom_dio.dart';

class AuthInterceptor extends InterceptorsWrapper {
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    final Dio _dio =
        kIsWeb ? Modular.get<CustomDioWeb>() : Modular.get<CustomDio>();
    if (err.response?.statusCode == 401) {
      final AuthController auth$ = Modular.get<AuthController>();
      await auth$.getUserData();
      RequestOptions options = err.response.requestOptions;
      await auth$.refreshAccessToken();
      options.headers['Authorization'] = 'Bearer ${auth$.user.accessToken}';
      final Response newResponse = await _dio.request(options.path,
          data: options.data,
          queryParameters: options.queryParameters,
          options: Options(
            headers: options.headers,
            contentType: options.contentType,
            method: options.method,
            extra: options.extra,
            requestEncoder: options.requestEncoder,
            responseDecoder: options.responseDecoder,
          ));
      return handler.resolve(newResponse);
    } else {
      return handler.next(err);
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    final AuthController auth$ = Modular.get<AuthController>();
    String token = auth$.user?.accessToken;
    if (token != null) {
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return handler.next(response);
  }
}
