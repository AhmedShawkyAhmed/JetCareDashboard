import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/core/network/models/key_value_model.dart';

part 'tab_access_model.g.dart';

@JsonSerializable()
class TabAccessModel{
  int? id;
  KeyValueModel? orders;
  KeyValueModel? corporates;
  KeyValueModel? clients;
  KeyValueModel? moderators;
  KeyValueModel? crews;
  KeyValueModel? category;
  KeyValueModel? offers;
  KeyValueModel? items;
  KeyValueModel? corporateItems;
  KeyValueModel? extrasItems;
  KeyValueModel? equipment;
  KeyValueModel? equipmentSchedule;
  KeyValueModel? ads;
  KeyValueModel? governorate;
  KeyValueModel? area;
  KeyValueModel? periods;
  KeyValueModel? support;
  KeyValueModel? notifications;
  KeyValueModel? info;

  TabAccessModel({
     this.id,
     this.crews,
     this.area,
     this.corporateItems,
     this.notifications,
     this.items,
     this.clients,
     this.periods,
     this.orders,
     this.equipment,
     this.equipmentSchedule,
     this.ads,
     this.category,
     this.corporates,
     this.extrasItems,
     this.governorate,
     this.info,
     this.moderators,
     this.offers,
     this.support,
});

  factory TabAccessModel.fromJson(Map<String, dynamic> json) =>
      _$TabAccessModelFromJson(json);

  Map<String, dynamic> toJson() => _$TabAccessModelToJson(this);
}