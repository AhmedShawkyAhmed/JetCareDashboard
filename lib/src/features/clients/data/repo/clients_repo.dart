import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/core/shared/requests/register_request.dart';
import 'package:jetboard/src/features/areas/data/models/area_model.dart';
import 'package:jetboard/src/features/clients/data/models/address_model.dart';
import 'package:jetboard/src/features/clients/data/requests/address_request.dart';
import 'package:jetboard/src/features/clients/service/clients_web_service.dart';

class ClientsRepo {
  final ClientsWebService webService;

  ClientsRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<UserModel>>>> getClients({
    String? keyword,
  }) async {
    try {
      var response = await webService.getClients(keyword: keyword);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<UserModel>>> addClient({
    required RegisterRequest request,
  }) async {
    try {
      var response = await webService.addClient(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> updateClient({
    required UserModel request,
  }) async {
    try {
      var response = await webService.updateClient(request: request);
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

  Future<NetworkResult<NetworkBaseModel>> deleteClient({
    required int id,
  }) async {
    try {
      var response = await webService.deleteClient(
        id: id,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<AddressModel>>>> getMyAddresses({
    required int clientId,
  }) async {
    try {
      var response = await webService.getMyAddresses(
        userId: clientId,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<AddressModel>>> addAddress({
    required AddressRequest request,
  }) async {
    try {
      var response = await webService.addAddress(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<AreaModel>>>> getStates() async {
    try {
      var response = await webService.getStates();
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
}
