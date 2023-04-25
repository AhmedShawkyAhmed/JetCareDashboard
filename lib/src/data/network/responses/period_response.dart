import '../../models/period_model.dart';

class PeriodResponsr {
  int? status;
  List<PeriodModel>? periodModel;
  PeriodModel? periodModell;
  

  PeriodResponsr({this.status, this.periodModel, this.periodModell});

  factory PeriodResponsr.fromJson(Map<String, dynamic> json) => PeriodResponsr(
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