import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/features/states/data/models/state_model.dart';
import 'package:jetboard/src/features/states/data/requests/state_request.dart';
import 'package:jetboard/src/features/states/service/states_web_service.dart';

class StateRepo {
  final StatesWebService webService;

  StateRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<StateModel>>>> getAllStates({
    String? keyword,
  }) async {
    try {
      var response = await webService.getAllStates(keyword: keyword);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> addState({
    required StateRequest request,
  }) async {
    try {
      var response = await webService.addState(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> updateState({
    required StateRequest request,
  }) async {
    try {
      var response = await webService.updateState(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> changeStateStatus({
    required StateRequest request,
  }) async {
    try {
      var response = await webService.changeStateStatus(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deleteState({
    required int id,
  }) async {
    try {
      var response = await webService.deleteState(id: id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
