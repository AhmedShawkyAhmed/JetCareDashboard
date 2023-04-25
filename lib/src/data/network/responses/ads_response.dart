import 'package:jetboard/src/data/models/ads_model.dart';

class AdsResponse {
  int? status;
  List<AdsModel>? adsModel;
  AdsModel? adModel;
  

  AdsResponse({this.status, this.adsModel, this.adModel});

  factory AdsResponse.fromJson(Map<String, dynamic> json) => AdsResponse(
        status: json['status'],
        adsModel: json["adsList"] != null
            ? List<AdsModel>.from(json["adsList"].map((x)=> AdsModel.fromJson(x)))
            :[],
         adModel: json['ad'] != null ? AdsModel.fromJson(json["ad"])
        :null,
      );

  Map<String, dynamic> toJson() => {
    "status":status,
    "adsList":List<dynamic>.from(adsModel!.map((e) => e.toJson())),
    "ad:":adModel,
  };
}