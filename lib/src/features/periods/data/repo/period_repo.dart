import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/features/periods/data/models/period_model.dart';
import 'package:jetboard/src/features/periods/data/requests/period_request.dart';
import 'package:jetboard/src/features/periods/service/period_web_service.dart';

class PeriodRepo {
  final PeriodWebService webService;

  PeriodRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<PeriodModel>>>> getPeriods({
    String? keyword,
  }) async {
    try {
      var response = await webService.getPeriods(keyword: keyword);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> addPeriod({
    required PeriodRequest request,
  }) async {
    try {
      var response = await webService.addPeriod(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> updatePeriod({
    required PeriodRequest request,
  }) async {
    try {
      var response = await webService.updatePeriod(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> changePeriodStatus({
    required PeriodRequest request,
  }) async {
    try {
      var response = await webService.changePeriodStatus(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deletePeriod({
    required int id,
  }) async {
    try {
      var response = await webService.deletePeriod(id: id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
