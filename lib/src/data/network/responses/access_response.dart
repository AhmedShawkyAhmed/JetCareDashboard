import 'package:jetboard/src/data/models/settings_model.dart';

class AccessResponse {
  int? status;
  String? message;
  SettingsModel? settings;

  AccessResponse({
    this.status,
    this.message,
    this.settings,
  });

  factory AccessResponse.fromJson(Map<String, dynamic> json) => AccessResponse(
        status: json['status'] ?? 0,
        message: json['message'] ?? "",
        settings: json["settings"] != null
            ? SettingsModel.fromJson(json["settings"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "settings": settings,
      };
}
