part of 'support_cubit.dart';

@immutable
abstract class SupportState {}

class SupportCupitInitial extends SupportState {}

class SupportSwitchState extends SupportState {}

class SupportLoadingState extends SupportState {}

class SupportSuccessState extends SupportState {}

class SupportErrorState extends SupportState {}

class DeleteLoadingState extends SupportState {}

class DeleteSuccessState extends SupportState {}

class DeleteErrorState extends SupportState {}

class ChangeSupportLoadingState extends SupportState {}

class ChangeSupportSuccessState extends SupportState {}

class ChangeSupportErrorState extends SupportState {}

class CommentSupportLoadingState extends SupportState {}
class CommentSupportSuccessState extends SupportState {}
class CommentSupportErrorState extends SupportState {}
