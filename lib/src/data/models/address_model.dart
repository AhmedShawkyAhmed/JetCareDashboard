class AddressModel {
  int? id, floor;
  String? phone, building, street, area, district, latitude, longitude;

  AddressModel({
    this.id,
    this.phone,
    this.area,
    this.latitude,
    this.longitude,
    this.street,
    this.building,
    this.district,
    this.floor,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['id'] ?? 0,
        floor: json['floor'] ?? 0,
        longitude: json['longitude'] ?? "",
        latitude: json['latitude'] ?? "",
        area: json['area'] ?? "",
        building: json['building'] ?? "",
        district: json['district'] ?? "",
        phone: json['phone'] ?? "",
        street: json['street'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'floor': floor,
        'longitude': longitude,
        'latitude': latitude,
        'area': area,
        'building': building,
        'district': district,
        'phone': phone,
        'street': street,
      };
}
