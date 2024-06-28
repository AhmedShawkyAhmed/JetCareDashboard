import 'package:freezed_annotation/freezed_annotation.dart';

part 'access_request.g.dart';

@JsonSerializable()
class AccessRequest {
  int? id;
  String? key;
  int? value;

  AccessRequest({
    this.id,
    this.key,
    this.value,
  });

  factory AccessRequest.fromJson(Map<String, dynamic> json) =>
      _$AccessRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AccessRequestToJson(this);
}
