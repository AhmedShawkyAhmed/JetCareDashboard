

import 'package:jetboard/src/data/models/packages_model.dart';

class PackageDetailsResponse {
  int? status;
  String? message;
  PackagesModel? packageModel;
  List<PackagesItemsData>? items;

  PackageDetailsResponse({
    this.status,
    this.message,
    this.packageModel,
    this.items,
  });

  factory PackageDetailsResponse.fromJson(Map<String, dynamic> json) =>
      PackageDetailsResponse(
        status: json['status'] ?? 0,
        message: json['message'] ?? "",
        packageModel:
        json["data"] != null ? PackagesModel.fromJson(json["data"]) : null,
        items: json["items"] != null
            ? List<PackagesItemsData>.from(
            json["items"].map((x) => PackagesItemsData.fromJson(x)))
            : json["items"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": packageModel,
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}
