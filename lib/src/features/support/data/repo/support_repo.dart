import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/features/support/data/models/support_model.dart';
import 'package:jetboard/src/features/support/data/requests/support_comment_request.dart';
import 'package:jetboard/src/features/support/service/support_web_service.dart';

class SupportRepo {
  final SupportWebService webService;

  SupportRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel>> supportComment({
    required SupportCommentRequest request,
  }) async {
    try {
      var response = await webService.supportComment(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<SupportModel>>>> getSupport({
    String? keyword,
  }) async {
    try {
      var response = await webService.getSupport(keyword: keyword);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deleteSupport({
    required int id,
  }) async {
    try {
      var response = await webService.deleteSupport(id: id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
