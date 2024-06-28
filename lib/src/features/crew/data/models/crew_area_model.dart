import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/features/areas/data/models/area_model.dart';

part 'crew_area_model.g.dart';

@JsonSerializable()
class CrewAreaModel {
  int? id;
  AreaModel? area;

  CrewAreaModel({
    this.id,
    this.area,
  });

  factory CrewAreaModel.fromJson(Map<String, dynamic> json) =>
      _$CrewAreaModelFromJson(json);

  Map<String, dynamic> toJson() => _$CrewAreaModelToJson(this);
}
