import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/features/areas/data/models/area_model.dart';
import 'package:jetboard/src/features/areas/data/requests/area_request.dart';
import 'package:jetboard/src/features/areas/service/areas_web_service.dart';
import 'package:jetboard/src/features/states/data/models/state_model.dart';

class AreaRepo {
  final AreasWebService webService;

  AreaRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<StateModel>>>>
      getAllStates() async {
    try {
      var response = await webService.getAllStates();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<AreaModel>>>> getAllAreas({
    String? keyword,
  }) async {
    try {
      var response = await webService.getAllAreas(keyword: keyword);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<AreaModel>>>> getAreasOfState({
    required int stateId,
  }) async {
    try {
      var response = await webService.getAreasOfState(stateId: stateId);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> addArea({
    required AreaRequest request,
  }) async {
    try {
      var response = await webService.addArea(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> updateArea({
    required AreaRequest request,
  }) async {
    try {
      var response = await webService.updateArea(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> changeAreaStatus({
    required AreaRequest request,
  }) async {
    try {
      var response = await webService.changeAreaStatus(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deleteArea({
    required int id,
  }) async {
    try {
      var response = await webService.deleteArea(id: id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
