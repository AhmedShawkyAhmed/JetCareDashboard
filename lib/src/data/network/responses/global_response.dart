
class GlobalResponse{
  int? status;
  String? message;

  GlobalResponse({
    this.status,
    this.message,
  });

  factory GlobalResponse.fromJson(Map<String, dynamic> json) => GlobalResponse(
    status: json["status"] ?? 0,
    message: json["message"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "status":status,
    "message": message,
  };

}