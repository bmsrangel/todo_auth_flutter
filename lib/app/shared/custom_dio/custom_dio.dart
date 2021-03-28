import 'package:dio/browser_imp.dart';
import 'package:dio/native_imp.dart';

import '../constants.dart';
import 'auth_interceptor.dart';

class CustomDio extends DioForNative {
  CustomDio() {
    options.baseUrl = BASE_URL;
    options.connectTimeout = 5000;
    interceptors.add(AuthInterceptor());
  }
}

class CustomDioWeb extends DioForBrowser {
  CustomDioWeb() {
    options.baseUrl = BASE_URL;
    options.connectTimeout = 5000;
    interceptors.add(AuthInterceptor());
  }
}
