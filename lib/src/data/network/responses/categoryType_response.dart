

import 'package:jetboard/src/data/models/category_model.dart';

class CategoryTypeResponse {
  int? status;
  List<CategoryModel>? categoryModel;

  CategoryTypeResponse({this.status, this.categoryModel});

  factory CategoryTypeResponse.fromJson(Map<String, dynamic> json) => CategoryTypeResponse(
        status: json['status'],
        categoryModel: json["categoryList"] != null
            ? List<CategoryModel>.from(json["categoryList"].map((x)=> CategoryModel.fromJson(x)))
            :[],
      );

  Map<String, dynamic> toJson() => {
    "status":status,
    "categoryList":List<dynamic>.from(categoryModel!.map((e) => e.toJson())),
  };
}