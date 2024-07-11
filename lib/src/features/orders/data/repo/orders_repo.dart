import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/core/utils/enums.dart';
import 'package:jetboard/src/features/orders/data/models/order_model.dart';
import 'package:jetboard/src/features/orders/data/requests/cart_request.dart';
import 'package:jetboard/src/features/orders/data/requests/order_request.dart';
import 'package:jetboard/src/features/orders/service/orders_web_service.dart';

class OrdersRepo {
  final OrdersWebService webService;

  OrdersRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<OrderModel>>>> getOrders({
    String? keyword,
    String? status,
  }) async {
    try {
      var response = await webService.getOrders(
        keyword: keyword,
        status: status,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> createOrder({
    required OrderRequest request,
  }) async {
    try {
      var response = await webService.createOrder(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> updateOrderStatus({
    required int id,
    required OrderStatus status,
    String? reason,
  }) async {
    try {
      var response = await webService.updateOrderStatus(
        id: id,
        status: status,
        reason: reason,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> updateAdminComment({
    required int orderId,
    required String adminComment,
  }) async {
    try {
      var response = await webService.updateAdminComment(
        orderId: orderId,
        adminComment: adminComment,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> assignOrder({
    required int orderId,
    required int crewId,
    required String date,
  }) async {
    try {
      var response = await webService.assignOrder(
        orderId: orderId,
        crewId: crewId,
        date: date,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> addExtraFees({
    required int orderId,
    required double extraFees,
  }) async {
    try {
      var response = await webService.addExtraFees(
        orderId: orderId,
        extraFees: extraFees,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> addToCart({
    required CartRequest request,
  }) async {
    try {
      var response = await webService.addToCart(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deleteOrder({
    required int id,
  }) async {
    try {
      var response = await webService.deleteOrder(id: id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
