import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel{
  int? id;
  String? title;
  String? message;
  String? createdAt;
  bool? isRead;

  NotificationModel({
    this.id,
    this.title,
    this.message,
    this.createdAt,
    this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}