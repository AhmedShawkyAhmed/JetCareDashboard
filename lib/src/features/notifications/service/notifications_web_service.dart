import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/notifications/data/models/notification_model.dart';
import 'package:jetboard/src/features/notifications/data/requests/notification_request.dart';
import 'package:retrofit/retrofit.dart';

part 'notifications_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class NotificationsWebService {
  factory NotificationsWebService(Dio dio, {String baseUrl}) =
      _NotificationsWebService;

  @GET(EndPoints.getNotifications)
  Future<NetworkBaseModel<List<NotificationModel>>> getNotifications();

  @POST(EndPoints.notifyUser)
  Future<NetworkBaseModel> notifyUser({
    @Body() NotificationRequest? request,
  });

  @POST(EndPoints.notifyAll)
  Future<NetworkBaseModel> notifyAll({
    @Body() NotificationRequest? request,
  });

  @POST(EndPoints.saveNotification)
  Future<NetworkBaseModel> saveNotification({
    @Body() NotificationRequest? request,
  });
}
