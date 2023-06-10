import 'package:jetboard/src/data/models/items_model.dart';

class ItemsResponse {
  int? status;
  List<ItemsModel>? itemsModel;
  List<ItemsModel>? corporate;
  ItemsModel? item;
  

  ItemsResponse({this.status, this.itemsModel, this.corporate,this.item});

  factory ItemsResponse.fromJson(Map<String, dynamic> json) => ItemsResponse(
        status: json['status'],
        itemsModel: json["itemList"] != null
            ? List<ItemsModel>.from(json["itemList"].map((x)=> ItemsModel.fromJson(x)))
            :[],
         corporate: json["corporateList"] != null
             ? List<ItemsModel>.from(json["corporateList"].map((x)=> ItemsModel.fromJson(x)))
             :[],
         item: json['item'] != null ? ItemsModel.fromJson(json["item"])
        :null,
      );

  Map<String, dynamic> toJson() => {
    "status":status,
    "itemList":List<dynamic>.from(itemsModel!.map((e) => e.toJson())),
    "corporateList":List<dynamic>.from(corporate!.map((e) => e.toJson())),
    "item:":item,
  };
}