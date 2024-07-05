import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_request.g.dart';

@JsonSerializable()
class AddressRequest {
  int? id;
  int? userId;
  String? phone;
  String? address;
  int? stateId;
  int? areaId;
  String? latitude;
  String? longitude;

  AddressRequest({
    this.id,
    this.phone,
    this.address,
    this.areaId,
    this.latitude,
    this.longitude,
    this.stateId,
    this.userId,
  });

  factory AddressRequest.fromJson(Map<String, dynamic> json) =>
      _$AddressRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddressRequestToJson(this);
}
