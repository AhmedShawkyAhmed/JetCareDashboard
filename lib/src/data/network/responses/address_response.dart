import 'package:jetboard/src/data/models/address_model.dart';

class AddressResponse {
  int? status;
  String? message;
  List<AddressModel>? address;
  AddressModel? addressModel;

  AddressResponse({
    this.status,
    this.message,
    this.address,
    this.addressModel,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      AddressResponse(
        status: json['status'] ?? 0,
        message: json['message'] ?? "",
        addressModel:  json["address"] != null
            ? AddressModel.fromJson(json["address"])
            : null,
        address: json["addressList"] != null
            ? List<AddressModel>.from(
            json["addressList"].map((x) => AddressModel.fromJson(x)))
            : json["addressList"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "address":addressModel,
    "addressList": List<dynamic>.from(address!.map((x) => x.toJson())),
  };
}
