import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetcare/src/features/address/data/models/area_model.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  int? id;
  String? phone;
  String? address;
  String? latitude;
  String? longitude;
  AreaModel? state;
  AreaModel? area;

  AddressModel({
    this.id,
    this.phone,
    this.area,
    this.latitude,
    this.longitude,
    this.state,
    this.address,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
