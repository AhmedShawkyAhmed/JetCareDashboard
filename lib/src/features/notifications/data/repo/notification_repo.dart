import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/features/notifications/data/models/notification_model.dart';
import 'package:jetboard/src/features/notifications/data/requests/notification_request.dart';
import 'package:jetboard/src/features/notifications/service/notifications_web_service.dart';

class NotificationRepo {
  final NotificationsWebService webService;

  NotificationRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<NotificationModel>>>>
      getNotifications() async {
    try {
      var response = await webService.getNotifications();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> notifyUser({
    required NotificationRequest request,
  }) async {
    try {
      var response = await webService.notifyUser(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> notifyAll({
    required NotificationRequest request,
  }) async {
    try {
      var response = await webService.notifyAll(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> saveNotification({
    required NotificationRequest request,
  }) async {
    try {
      var response = await webService.saveNotification(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
