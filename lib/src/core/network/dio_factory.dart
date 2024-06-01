import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'default_headers_interceptor.dart';
import 'end_points.dart';

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    dio.options = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
    );

    if (!kReleaseMode) {
      dio.interceptors.addAll([
        LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true,
        ),
        DefaultHeadersInterceptor(dio: dio)
      ]);
    }

    return dio;
  }
}
