import '../../models/packages_model.dart';

class CategoryResponse {
  int? status;
  List<PackagesModel>? categoryModel;
  PackagesModel? categoryDataModel;
  

  CategoryResponse({this.status, this.categoryModel,this.categoryDataModel});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
        status: json['status'],
        categoryModel: json["data"] != null
            ? List<PackagesModel>.from(json["data"].map((x)=> PackagesModel.fromJson(x)))
            :[],
         categoryDataModel: json['category'] != null ? PackagesModel.fromJson(json["category"])
        :null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(categoryModel!.map((e) => e.toJson())),
    "category:": categoryDataModel,
  };
}