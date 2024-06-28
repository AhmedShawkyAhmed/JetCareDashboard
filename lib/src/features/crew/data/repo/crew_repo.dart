import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/core/shared/requests/register_request.dart';
import 'package:jetboard/src/features/crew/data/models/crew_area_model.dart';
import 'package:jetboard/src/features/crew/service/crew_web_service.dart';

class CrewRepo {
  final CrewWebService webService;

  CrewRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<UserModel>>>> getCrews({
    String? keyword,
  }) async {
    try {
      var response = await webService.getCrews(keyword: keyword);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> addCrew({
    required RegisterRequest request,
  }) async {
    try {
      var response = await webService.addCrew(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> updateCrew({
    required UserModel request,
  }) async {
    try {
      var response = await webService.updateCrew(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> activateAccount({
    required int userId,
  }) async {
    try {
      var response = await webService.activateAccount(userId: userId);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> stopAccount({
    required int userId,
  }) async {
    try {
      var response = await webService.stopAccount(userId: userId);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> userAdminComment({
    required int userId,
    required String adminComment,
  }) async {
    try {
      var response = await webService.userAdminComment(
        userId: userId,
        adminComment: adminComment,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deleteCrew({
    required int id,
  }) async {
    try {
      var response = await webService.deleteCrew(
        id: id,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<CrewAreaModel>>>> getCrewAreas({
    required int crewId,
  }) async {
    try {
      var response = await webService.getCrewAreas(crewId: crewId);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> addAreaToCrew({
    required int crewId,
    required int areaId,
  }) async {
    try {
      var response = await webService.addAreaToCrew(
        crewId: crewId,
        areaId: areaId,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deleteCrewArea({
    required int id,
  }) async {
    try {
      var response = await webService.deleteCrewArea(
        id: id,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
