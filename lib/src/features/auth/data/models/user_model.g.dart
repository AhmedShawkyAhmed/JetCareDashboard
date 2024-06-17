// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      rate: json['rate'] as num?,
      role: $enumDecodeNullable(_$RolesEnumMap, json['role']),
      token: json['token'] as String?,
      fcm: json['fcm'] as String?,
      isActive: json['is_active'] as bool?,
      isArchived: json['is_archived'] as bool?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('phone', instance.phone);
  writeNotNull('email', instance.email);
  writeNotNull('rate', instance.rate);
  writeNotNull('role', _$RolesEnumMap[instance.role]);
  writeNotNull('token', instance.token);
  writeNotNull('fcm', instance.fcm);
  writeNotNull('is_active', instance.isActive);
  writeNotNull('is_archived', instance.isArchived);
  return val;
}

const _$RolesEnumMap = {
  Roles.admin: 'admin',
  Roles.moderator: 'moderator',
  Roles.client: 'client',
  Roles.crew: 'crew',
};
