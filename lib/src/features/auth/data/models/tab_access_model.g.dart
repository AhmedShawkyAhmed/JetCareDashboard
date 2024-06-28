// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_access_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TabAccessModel _$TabAccessModelFromJson(Map<String, dynamic> json) =>
    TabAccessModel(
      id: (json['id'] as num?)?.toInt(),
      crews: json['crews'] == null
          ? null
          : KeyValueModel.fromJson(json['crews'] as Map<String, dynamic>),
      area: json['area'] == null
          ? null
          : KeyValueModel.fromJson(json['area'] as Map<String, dynamic>),
      corporateItems: json['corporate_items'] == null
          ? null
          : KeyValueModel.fromJson(
              json['corporate_items'] as Map<String, dynamic>),
      notifications: json['notifications'] == null
          ? null
          : KeyValueModel.fromJson(
              json['notifications'] as Map<String, dynamic>),
      items: json['items'] == null
          ? null
          : KeyValueModel.fromJson(json['items'] as Map<String, dynamic>),
      clients: json['clients'] == null
          ? null
          : KeyValueModel.fromJson(json['clients'] as Map<String, dynamic>),
      periods: json['periods'] == null
          ? null
          : KeyValueModel.fromJson(json['periods'] as Map<String, dynamic>),
      orders: json['orders'] == null
          ? null
          : KeyValueModel.fromJson(json['orders'] as Map<String, dynamic>),
      equipment: json['equipment'] == null
          ? null
          : KeyValueModel.fromJson(json['equipment'] as Map<String, dynamic>),
      equipmentSchedule: json['equipment_schedule'] == null
          ? null
          : KeyValueModel.fromJson(
              json['equipment_schedule'] as Map<String, dynamic>),
      ads: json['ads'] == null
          ? null
          : KeyValueModel.fromJson(json['ads'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : KeyValueModel.fromJson(json['category'] as Map<String, dynamic>),
      corporates: json['corporates'] == null
          ? null
          : KeyValueModel.fromJson(json['corporates'] as Map<String, dynamic>),
      extrasItems: json['extras_items'] == null
          ? null
          : KeyValueModel.fromJson(
              json['extras_items'] as Map<String, dynamic>),
      governorate: json['governorate'] == null
          ? null
          : KeyValueModel.fromJson(json['governorate'] as Map<String, dynamic>),
      info: json['info'] == null
          ? null
          : KeyValueModel.fromJson(json['info'] as Map<String, dynamic>),
      moderators: json['moderators'] == null
          ? null
          : KeyValueModel.fromJson(json['moderators'] as Map<String, dynamic>),
      offers: json['offers'] == null
          ? null
          : KeyValueModel.fromJson(json['offers'] as Map<String, dynamic>),
      support: json['support'] == null
          ? null
          : KeyValueModel.fromJson(json['support'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TabAccessModelToJson(TabAccessModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('orders', instance.orders?.toJson());
  writeNotNull('corporates', instance.corporates?.toJson());
  writeNotNull('clients', instance.clients?.toJson());
  writeNotNull('moderators', instance.moderators?.toJson());
  writeNotNull('crews', instance.crews?.toJson());
  writeNotNull('category', instance.category?.toJson());
  writeNotNull('offers', instance.offers?.toJson());
  writeNotNull('items', instance.items?.toJson());
  writeNotNull('corporate_items', instance.corporateItems?.toJson());
  writeNotNull('extras_items', instance.extrasItems?.toJson());
  writeNotNull('equipment', instance.equipment?.toJson());
  writeNotNull('equipment_schedule', instance.equipmentSchedule?.toJson());
  writeNotNull('ads', instance.ads?.toJson());
  writeNotNull('governorate', instance.governorate?.toJson());
  writeNotNull('area', instance.area?.toJson());
  writeNotNull('periods', instance.periods?.toJson());
  writeNotNull('support', instance.support?.toJson());
  writeNotNull('notifications', instance.notifications?.toJson());
  writeNotNull('info', instance.info?.toJson());
  return val;
}
