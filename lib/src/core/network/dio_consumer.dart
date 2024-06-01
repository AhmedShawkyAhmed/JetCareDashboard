import 'package:dio/dio.dart';

import 'network_service.dart';

class DioConsumer implements NetworkService {
  final Dio dio;

  DioConsumer(this.dio);

  @override
  Future<Response> post({
    required String url,
    required dynamic body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio.post(
        url,
        data: body,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> get({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    try {
      Response response = await dio.get(url, queryParameters: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
