// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkBaseModel<T> _$NetworkBaseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    NetworkBaseModel<T>(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$NetworkBaseModelToJson<T>(
  NetworkBaseModel<T> instance,
  Object? Function(T value) toJsonT,
) {
  final val = <String, dynamic>{
    'status': instance.status,
    'message': instance.message,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', _$nullableGenericToJson(instance.data, toJsonT));
  return val;
}

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
