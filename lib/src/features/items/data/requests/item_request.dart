import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/core/utils/enums.dart';

part 'item_request.g.dart';

@JsonSerializable()
class ItemRequest {
  int? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  String? unit;
  num? price;
  num? quantity;
  ItemTypes? type;
  bool? hasShipping;
  bool? isActive;

  ItemRequest({
    this.id,
    this.nameAr,
    this.nameEn,
    this.price,
    this.isActive,
    this.type,
    this.descriptionAr,
    this.descriptionEn,
    this.hasShipping,
    this.quantity,
    this.unit,
  });

  factory ItemRequest.fromJson(Map<String, dynamic> json) =>
      _$ItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ItemRequestToJson(this);
}
