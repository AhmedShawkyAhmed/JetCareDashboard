import 'package:dio/dio.dart';
import 'package:jetboard/src/constants/end_points.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }


  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json;multipart/form-data',
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> body,
    bool formData=false,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    return await dio!.post(
      url,
      data:formData? FormData.fromMap(body):body,
    );
  }
}
