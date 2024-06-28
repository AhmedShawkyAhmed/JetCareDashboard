import 'package:freezed_annotation/freezed_annotation.dart';

part 'key_value_model.g.dart';

@JsonSerializable()
class KeyValueModel {
  String? key;
  bool? value;

  KeyValueModel({
    this.key,
    this.value,
  });


  factory KeyValueModel.fromJson(Map<String, dynamic> json) =>
      _$KeyValueModelFromJson(json);

  Map<String, dynamic> toJson() => _$KeyValueModelToJson(this);
}
