// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_value_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyValueModel _$KeyValueModelFromJson(Map<String, dynamic> json) =>
    KeyValueModel(
      key: json['key'] as String?,
      value: json['value'] as bool?,
    );

Map<String, dynamic> _$KeyValueModelToJson(KeyValueModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('key', instance.key);
  writeNotNull('value', instance.value);
  return val;
}
