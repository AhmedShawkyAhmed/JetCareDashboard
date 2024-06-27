// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarRequest _$CalendarRequestFromJson(Map<String, dynamic> json) =>
    CalendarRequest(
      calendarId: (json['calendar_id'] as num).toInt(),
      areaId: (json['area_id'] as num).toInt(),
      periodIds: (json['period_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$CalendarRequestToJson(CalendarRequest instance) =>
    <String, dynamic>{
      'calendar_id': instance.calendarId,
      'area_id': instance.areaId,
      'period_ids': instance.periodIds,
    };
