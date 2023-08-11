import '../../models/period_model.dart';

class PeriodResponse {
  int? status;
  List<PeriodModel>? periodModel;
  PeriodModel? periodModell;
  

  PeriodResponse({this.status, this.periodModel, this.periodModell});

  factory PeriodResponse.fromJson(Map<String, dynamic> json) => PeriodResponse(
        status: json['status'],
        periodModel: json["periodList"] != null
            ? List<PeriodModel>.from(json["periodList"].map((x)=> PeriodModel.fromJson(x)))
            :[],
         periodModell: json['period'] != null ? PeriodModel.fromJson(json["period"])
        :null,
      );

  Map<String, dynamic> toJson() => {
    "status":status,
    "periodList":List<dynamic>.from(periodModel!.map((e) => e.toJson())),
    "period:":periodModell,
  };
}