
import 'package:jetboard/src/data/models/area_model.dart';

class AddressModel {
  int? id;
  String? phone, address, latitude, longitude;
  AreaModel? state, area;

  AddressModel({
    this.id,
    this.phone,
    this.area,
    this.latitude,
    this.longitude,
    this.state,
    this.address,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json['id'] ?? 0,
    longitude: json['longitude'] ?? "",
    latitude: json['latitude'] ?? "",
    area: json["area"] != null
        ? AreaModel.fromJson(json["area"])
        : null,
    address: json['address'] ?? "",
    state: json["state"] != null
        ? AreaModel.fromJson(json["state"])
        : null,
    phone: json['phone'] ?? "",
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'longitude': longitude,
    'latitude': latitude,
    'area': area,
    'state': state,
    'phone': phone,
    'address': address,
  };
}
