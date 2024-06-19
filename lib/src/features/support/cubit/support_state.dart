part of 'support_cubit.dart';

@immutable
sealed class SupportState {}

final class SupportInitial extends SupportState {}

class SupportCommentLoading extends SupportState {}
class SupportCommentSuccess extends SupportState {}
class SupportCommentFailure extends SupportState {}

class GetSupportLoading extends SupportState {}
class GetSupportSuccess extends SupportState {}
class GetSupportFailure extends SupportState {}

class DeleteSupportLoading extends SupportState {}
class DeleteSupportSuccess extends SupportState {}
class DeleteSupportFailure extends SupportState {}
