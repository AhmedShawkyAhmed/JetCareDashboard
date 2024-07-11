import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/core/shared/globals.dart';
import 'package:jetboard/src/features/auth/data/models/tab_access_model.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/features/auth/data/requests/fcm_request.dart';
import 'package:jetboard/src/features/auth/data/requests/login_request.dart';
import 'package:jetboard/src/features/auth/service/auth_web_service.dart';

class AuthRepo {
  final AuthWebService webService;

  AuthRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<UserModel>>> login({
    required LoginRequest request,
  }) async {
    try {
      var response = await webService.login(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> fcm({
    required FCMRequest request,
  }) async {
    try {
      var response = await webService.fcm(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<UserModel>>> profile() async {
    try {
      var response = await webService.profile();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<TabAccessModel>>> getTabAccess() async {
    try {
      var response = await webService.getTabAccess(id: Globals.userData.id!);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> logout() async {
    try {
      var response = await webService.logout();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
