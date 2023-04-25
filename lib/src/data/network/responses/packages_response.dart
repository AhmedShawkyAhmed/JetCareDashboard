

import 'package:jetboard/src/data/models/packages_model.dart';

class PackagesResponse {
  int? status;
  List<PackagesModel>? packagesModel;
  List<PackagesItemsData>? packageDetails;
  PackagesModel? packagesDataModel;
  

  PackagesResponse({this.status, this.packagesModel,this.packagesDataModel,this.packageDetails});

  factory PackagesResponse.fromJson(Map<String, dynamic> json) => PackagesResponse(
        status: json['status'],
        packagesModel: json["data"] != null
            ? List<PackagesModel>.from(json["data"].map((x)=> PackagesModel.fromJson(x)))
            :[],
        packageDetails: json["items"] != null
            ? List<PackagesItemsData>.from(json["items"].map((x)=> PackagesItemsData.fromJson(x)))
            :[],
         packagesDataModel: json['package'] != null ? PackagesModel.fromJson(json["package"])
        :null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(packagesModel!.map((e) => e.toJson())),
    "items": List<dynamic>.from(packagesModel!.map((e) => e.toJson())),
    "package:": packagesDataModel,
  };
}