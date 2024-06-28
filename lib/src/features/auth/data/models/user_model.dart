import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/core/utils/enums.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  num? rate;
  Roles? role;
  String? token;
  String? fcm;
  String? adminComment;
  bool? isActive;
  bool? isArchived;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.rate,
    this.role,
    this.token,
    this.fcm,
    this.adminComment,
    this.isActive,
    this.isArchived,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
