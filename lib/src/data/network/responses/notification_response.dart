
import 'package:jetboard/src/data/models/notification_model.dart';

class NotificationResponse {
  int? status;
  String? message;
  List<NotificationModel>? notifications;

  NotificationResponse({
    this.status,
    this.message,
    this.notifications,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        status: json['status'] ?? 0,
        message: json['message'] ?? "",
        notifications: json["data"] != null
            ? List<NotificationModel>.from(
            json["data"].map((x) => NotificationModel.fromJson(x)))
            : json["data"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(notifications!.map((x) => x.toJson())),
  };
}
