import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/features/info/data/models/info_model.dart';
import 'package:jetboard/src/features/info/data/requests/info_request.dart';
import 'package:jetboard/src/features/info/service/info_web_service.dart';

class InfoRepo {
  final InfoWebService webService;

  InfoRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<InfoModel>>>> getInfo({
    String? keyword,
    String? type,
  }) async {
    try {
      var response = await webService.getInfo(
        keyword: keyword,
        type: type,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<InfoModel>>>> getTypes() async {
    try {
      var response = await webService.getTypes();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<InfoModel>>>> getUnit() async {
    try {
      var response = await webService.getUnit();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<InfoModel>>>> getRole() async {
    try {
      var response = await webService.getRole();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<InfoModel>>>> getCategory() async {
    try {
      var response = await webService.getCategory();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<InfoModel>>>>
      getItemsTypes() async {
    try {
      var response = await webService.getItemsTypes();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> addInfo({
    required InfoRequest request,
  }) async {
    try {
      var response = await webService.addInfo(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> updateInfo({
    required InfoRequest request,
  }) async {
    try {
      var response = await webService.updateInfo(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deleteInfo({
    required int id,
  }) async {
    try {
      var response = await webService.deleteInfo(
        id: id,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
