import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  String name;
  String phone;
  String role;
  String email;
  String password;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? confirmPassword;

  RegisterRequest({
    required this.name,
    required this.phone,
    required this.role,
    required this.email,
    required this.password,
    this.confirmPassword,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
