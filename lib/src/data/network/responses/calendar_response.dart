import 'package:jetboard/src/data/models/calendar_model.dart';

class calendarResponse {
  int? status;
  List<CalendarModel>? calendarModel;

  calendarResponse({this.status, this.calendarModel});

  factory calendarResponse.fromJson(Map<String, dynamic> json) =>
      calendarResponse(
        status: json['status'],
        calendarModel: json["dateList"] != null
            ? List<CalendarModel>.from(
                json["dateList"].map((x) => CalendarModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "dateList": List<dynamic>.from(calendarModel!.map((e) => e.toJson())),
      };
}
