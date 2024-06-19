import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_comment_request.g.dart';

@JsonSerializable()
class SupportCommentRequest {
  int id;
  String comment;

  SupportCommentRequest({
    required this.id,
    required this.comment,
  });

  factory SupportCommentRequest.fromJson(Map<String, dynamic> json) =>
      _$SupportCommentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SupportCommentRequestToJson(this);
}
