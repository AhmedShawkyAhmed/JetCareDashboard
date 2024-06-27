import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/features/areas/data/models/area_model.dart';
import 'package:jetboard/src/features/periods/data/models/period_model.dart';

part 'calendar_model.g.dart';

@JsonSerializable()
class CalendarModel {
  int? id;
  @JsonKey(name: "db_date")
  String? date;
  int? year;
  int? month;
  int? day;
  String? dayName;
  String? monthName;
  List<PeriodModel>? periods;
  List<AreaModel>? area;

  CalendarModel({
    this.id,
    this.day,
    this.date,
    this.periods,
    this.area,
    this.month,
    this.year,
    this.dayName,
    this.monthName,
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarModelFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarModelToJson(this);
}
