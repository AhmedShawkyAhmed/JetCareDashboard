class NotificationModel {
  int? id;
  int? userId;
  int? isRead;
  String? title;
  String? message;
  String? createdAt;

  NotificationModel({
    this.id,
    this.userId,
    this.isRead,
    this.title,
    this.message,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json['id'] ?? 0,
    userId: json['userId'] ?? 0,
    isRead: json['isRead'] ?? 0,
    title: json['title'] ?? "",
    message: json['message'] ?? "",
    createdAt: json['createdAt'] ?? "",
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'isRead': isRead,
    'title': title,
    'message': message,
    'createdAt': createdAt,
  };
}
