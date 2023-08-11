import 'package:jetboard/src/data/models/calender_model.dart';

class CalenderResponse {
  int? status;
  List<CalenderModel>? calenderModel;

  CalenderResponse({
    this.status,
    this.calenderModel,
  });

  factory CalenderResponse.fromJson(Map<String, dynamic> json) => CalenderResponse(
    status: json['status'],
    calenderModel: json["calender"] != null
        ? List<CalenderModel>.from(json["calender"].map((x)=> CalenderModel.fromJson(x)))
        :[],

  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "calender": List<dynamic>.from(calenderModel!.map((e) => e.toJson())),
  };
}
