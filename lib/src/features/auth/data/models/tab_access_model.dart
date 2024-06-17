import 'package:freezed_annotation/freezed_annotation.dart';

part 'tab_access_model.g.dart';

@JsonSerializable()
class TabAccessModel{
  int? id;
  int? moderatorId;
  bool? orders;
  bool? corporates;
  bool? clients;
  bool? moderators;
  bool? crews;
  bool? category;
  bool? offers;
  bool? items;
  bool? corporateItems;
  bool? extrasItems;
  bool? equipment;
  bool? equipmentSchedule;
  bool? ads;
  bool? governorate;
  bool? area;
  bool? periods;
  bool? support;
  bool? notifications;
  bool? info;

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
     this.moderatorId,
     this.moderators,
     this.offers,
     this.support,
});

  factory TabAccessModel.fromJson(Map<String, dynamic> json) =>
      _$TabAccessModelFromJson(json);

  Map<String, dynamic> toJson() => _$TabAccessModelToJson(this);
}