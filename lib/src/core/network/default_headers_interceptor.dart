import 'package:dio/dio.dart';
import 'package:jetboard/src/core/constants/cache_keys.dart';
import 'package:jetboard/src/core/services/cache_service.dart';

class DefaultHeadersInterceptor extends Interceptor {
  final Dio dio;

  DefaultHeadersInterceptor({required this.dio});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${CacheService.get(key: CacheKeys.token)}",
    });
    return handler.next(options);
  }
}
