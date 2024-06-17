// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_access_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TabAccessModel _$TabAccessModelFromJson(Map<String, dynamic> json) =>
    TabAccessModel(
      id: (json['id'] as num?)?.toInt(),
      crews: json['crews'] as bool?,
      area: json['area'] as bool?,
      corporateItems: json['corporate_items'] as bool?,
      notifications: json['notifications'] as bool?,
      items: json['items'] as bool?,
      clients: json['clients'] as bool?,
      periods: json['periods'] as bool?,
      orders: json['orders'] as bool?,
      equipment: json['equipment'] as bool?,
      equipmentSchedule: json['equipment_schedule'] as bool?,
      ads: json['ads'] as bool?,
      category: json['category'] as bool?,
      corporates: json['corporates'] as bool?,
      extrasItems: json['extras_items'] as bool?,
      governorate: json['governorate'] as bool?,
      info: json['info'] as bool?,
      moderatorId: (json['moderator_id'] as num?)?.toInt(),
      moderators: json['moderators'] as bool?,
      offers: json['offers'] as bool?,
      support: json['support'] as bool?,
    );

Map<String, dynamic> _$TabAccessModelToJson(TabAccessModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('moderator_id', instance.moderatorId);
  writeNotNull('orders', instance.orders);
  writeNotNull('corporates', instance.corporates);
  writeNotNull('clients', instance.clients);
  writeNotNull('moderators', instance.moderators);
  writeNotNull('crews', instance.crews);
  writeNotNull('category', instance.category);
  writeNotNull('offers', instance.offers);
  writeNotNull('items', instance.items);
  writeNotNull('corporate_items', instance.corporateItems);
  writeNotNull('extras_items', instance.extrasItems);
  writeNotNull('equipment', instance.equipment);
  writeNotNull('equipment_schedule', instance.equipmentSchedule);
  writeNotNull('ads', instance.ads);
  writeNotNull('governorate', instance.governorate);
  writeNotNull('area', instance.area);
  writeNotNull('periods', instance.periods);
  writeNotNull('support', instance.support);
  writeNotNull('notifications', instance.notifications);
  writeNotNull('info', instance.info);
  return val;
}
