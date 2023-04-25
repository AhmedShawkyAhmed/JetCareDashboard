import 'package:jetboard/src/data/models/support_model.dart';

class SupportResponse {
  int? status;
  List<SupportModel>? supportModel;

  SupportResponse({this.status, this.supportModel});

  factory SupportResponse.fromJson(Map<String, dynamic> json) => SupportResponse(
        status: json['status'],
        supportModel: json["supportList"] != null
            ? List<SupportModel>.from(json["supportList"].map((x)=> SupportModel.fromJson(x)))
            :[],
      );

  Map<String, dynamic> toJson() => {
    "status":status,
    "supportList":List<dynamic>.from(supportModel!.map((e) => e.toJson())),
  };
}