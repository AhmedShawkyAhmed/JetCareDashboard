import 'package:jetboard/src/data/models/area_model.dart';
import 'package:jetboard/src/features/periods/data/models/period_model.dart';

class CalenderModel {
  int? id;
  String? date;
  int? year;
  int? month;
  int? day;
  String? dayName;
  String? monthName;
  List<PeriodModel>? periods;
  List<AreaModel>? areas;

  CalenderModel({
    this.id,
    this.day,
    this.date,
    this.periods,
    this.areas,
    this.month,
    this.year,
    this.dayName,
    this.monthName,
  });

  factory CalenderModel.fromJson(Map<String, dynamic> json) => CalenderModel(
    id: json['id'] ?? 0,
    day: json['day'] ?? 0,
    date: json['db_date'] ?? "",
    year: json['year'] ?? 0,
    month: json['month'] ?? 0,
    dayName: json['day_name'] ?? "",
    monthName: json['month_name'] ?? "",
    periods: json["periods"] != null
        ? List<PeriodModel>.from(json["periods"].map((x)=> PeriodModel.fromJson(x)))
        :[],
    areas: json["area"] != null
        ? List<AreaModel>.from(json["area"].map((x)=> AreaModel.fromJson(x)))
        :[],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'day': day,
    'db_date': date,
    'year': year,
    'month': month,
    'day_name': dayName,
    'month_name': monthName,
    'periods': List<dynamic>.from(periods!.map((e) => e.toJson())),
    'area': List<dynamic>.from(areas!.map((e) => e.toJson())),
  };
}
