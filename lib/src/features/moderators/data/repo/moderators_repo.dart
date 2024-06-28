import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/features/auth/data/models/user_model.dart';
import 'package:jetboard/src/features/moderators/data/models/moderator_access_model.dart';
import 'package:jetboard/src/features/moderators/data/requests/access_request.dart';
import 'package:jetboard/src/features/moderators/data/requests/register_request.dart';
import 'package:jetboard/src/features/moderators/service/moderators_web_service.dart';

class ModeratorsRepo {
  final ModeratorsWebService webService;

  ModeratorsRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<UserModel>>>> getModerators({
    String? keyword,
  }) async {
    try {
      var response = await webService.getModerators(keyword: keyword);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<ModeratorAccessModel>>> getTabAccess({
    required int id,
  }) async {
    try {
      var response = await webService.getTabAccess(id: id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> register({
    required RegisterRequest request,
  }) async {
    try {
      var response = await webService.register(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> updateAccount({
    required UserModel request,
  }) async {
    try {
      var response = await webService.updateAccount(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> createAccess({
    required int moderatorId,
  }) async {
    try {
      var response = await webService.createAccess(moderatorId: moderatorId);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> updateAccess({
    required AccessRequest request,
  }) async {
    try {
      var response = await webService.updateAccess(request: request);
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

  Future<NetworkResult<NetworkBaseModel>> deleteAccount({
    required int id,
  }) async {
    try {
      var response = await webService.deleteAccount(
        id: id,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
