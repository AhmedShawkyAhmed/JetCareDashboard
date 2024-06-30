import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/features/corporate/data/models/corporate_order_model.dart';
import 'package:jetboard/src/features/corporate/data/requests/corporate_order_request.dart';
import 'package:jetboard/src/features/corporate/service/corporate_web_service.dart';

class CorporateRepo {
  final CorporateWebService webService;

  CorporateRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<CorporateOrderModel>>>>
      getCorporateOrders({
    String? keyword,
  }) async {
    try {
      var response = await webService.getCorporateOrders(keyword: keyword);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<CorporateOrderModel>>> addCorporateOrder({
    required CorporateOrderRequest request,
  }) async {
    try {
      var response = await webService.addCorporateOrder(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> corporateAdminComment({
    required int id,
    required String adminComment,
  }) async {
    try {
      var response = await webService.corporateAdminComment(
        id: id,
        adminComment: adminComment,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> contactCorporate({
    required int id,
  }) async {
    try {
      var response = await webService.contactCorporate(id: id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
