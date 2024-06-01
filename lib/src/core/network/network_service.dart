import 'package:dio/dio.dart';

abstract class NetworkService {
  Future<Response> post({
    required String url,
    required dynamic body,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> get({
    required String url,
    Map<String, dynamic>? query,
  });
}
