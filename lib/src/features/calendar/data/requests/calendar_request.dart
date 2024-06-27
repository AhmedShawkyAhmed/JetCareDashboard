import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/features/areas/data/models/area_model.dart';
import 'package:jetboard/src/features/calendar/data/models/calendar_model.dart';

part 'calendar_request.g.dart';

@JsonSerializable()
class CalendarRequest {
  int calendarId;
  int areaId;
  List<int> periodIds;
  @JsonKey(includeFromJson: false, includeToJson: false)
  AreaModel? areaModel;
  @JsonKey(includeFromJson: false, includeToJson: false)
  CalendarModel? calendarModel;

  CalendarRequest({
    required this.calendarId,
    required this.areaId,
    required this.periodIds,
    this.areaModel,
    this.calendarModel,
  });

  factory CalendarRequest.fromJson(Map<String, dynamic> json) =>
      _$CalendarRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarRequestToJson(this);
}
