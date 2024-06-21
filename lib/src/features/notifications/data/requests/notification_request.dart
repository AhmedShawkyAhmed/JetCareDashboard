import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_request.g.dart';

@JsonSerializable()
class NotificationRequest {
  int? userId;
  String title;
  String message;

  NotificationRequest({
    this.userId,
    required this.title,
    required this.message,
  });

  factory NotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationRequestToJson(this);
}
