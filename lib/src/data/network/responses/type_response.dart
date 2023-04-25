import 'package:jetboard/src/data/models/type_model.dart';

class TypeResponse {
  int? status;
  List<TypeModel>? typeModel;

  TypeResponse({this.status, this.typeModel});

  factory TypeResponse.fromJson(Map<String, dynamic> json) => TypeResponse(
        status: json['status'],
        typeModel: json["typeList"] != null
            ? List<TypeModel>.from(json["typeList"].map((x)=> TypeModel.fromJson(x)))
            :[],
      );

  Map<String, dynamic> toJson() => {
    "status":status,
    "typeList":List<dynamic>.from(typeModel!.map((e) => e.toJson())),
  };
}