class AddressRequest {
  final int userId,stateId,areaId;
  final String phone, address, latitude, longitude;

  AddressRequest({
    required this.userId,
    required this.stateId,
    required this.areaId,
    required this.address,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });
}
