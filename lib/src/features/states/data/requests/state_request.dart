import 'package:freezed_annotation/freezed_annotation.dart';

part 'state_request.g.dart';

@JsonSerializable()
class StateRequest {
  int? id;
  String? nameAr;
  String? nameEn;
  bool? isActive;

  StateRequest({
    this.id,
    this.nameAr,
    this.nameEn,
    this.isActive,
  });

  factory StateRequest.fromJson(Map<String, dynamic> json) =>
      _$StateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$StateRequestToJson(this);
}
