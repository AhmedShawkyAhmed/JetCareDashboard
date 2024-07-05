import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_item_request.g.dart';

@JsonSerializable()
class CategoryItemRequest {
  int categoryId;
  List<int>? packageIds;
  List<int>? itemIds;

  CategoryItemRequest({
    required this.categoryId,
    this.packageIds,
    this.itemIds,
  });

  factory CategoryItemRequest.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryItemRequestToJson(this);
}
