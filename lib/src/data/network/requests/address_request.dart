class AddressRequest {
  final int userId;
  final String phone, floor, building, street, area, district, latitude, longitude;

  AddressRequest({
    required this.userId,
    required this.floor,
    required this.phone,
    required this.building,
    required this.street,
    required this.area,
    required this.district,
    required this.latitude,
    required this.longitude,
  });
}
