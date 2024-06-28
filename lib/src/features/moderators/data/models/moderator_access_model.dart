import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/core/network/models/key_value_model.dart';

part 'moderator_access_model.g.dart';

@JsonSerializable()
class ModeratorAccessModel{
  int? id;
  List<KeyValueModel>? access;

  ModeratorAccessModel({
    this.id,
    this.access,
  });

  factory ModeratorAccessModel.fromJson(Map<String, dynamic> json) =>
      _$ModeratorAccessModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModeratorAccessModelToJson(this);
}