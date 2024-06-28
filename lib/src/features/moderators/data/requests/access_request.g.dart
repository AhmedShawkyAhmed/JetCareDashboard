// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessRequest _$AccessRequestFromJson(Map<String, dynamic> json) =>
    AccessRequest(
      id: (json['id'] as num?)?.toInt(),
      key: json['key'] as String?,
      value: (json['value'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AccessRequestToJson(AccessRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('key', instance.key);
  writeNotNull('value', instance.value);
  return val;
}
