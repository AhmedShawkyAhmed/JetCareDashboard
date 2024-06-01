import 'package:json_annotation/json_annotation.dart';

part 'network_base_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class NetworkBaseModel<T> {
  int status;
  String message;
  T? data;

  NetworkBaseModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory NetworkBaseModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$NetworkBaseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$NetworkBaseModelToJson(this, toJsonT);
}
