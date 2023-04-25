
import 'package:jetboard/src/data/models/itemsType_model.dart';

class ItemsTypeResponse {
  int? status;
  List<ItemsTypeModel>? itemsTypeModel;

  ItemsTypeResponse({this.status, this.itemsTypeModel});

  factory ItemsTypeResponse.fromJson(Map<String, dynamic> json) => ItemsTypeResponse(
        status: json['status'],
        itemsTypeModel: json["itemsList"] != null
            ? List<ItemsTypeModel>.from(json["itemsList"].map((x)=> ItemsTypeModel.fromJson(x)))
            :[],
      );

  Map<String, dynamic> toJson() => {
    "status":status,
    "itemsList":List<dynamic>.from(itemsTypeModel!.map((e) => e.toJson())),
  };
}