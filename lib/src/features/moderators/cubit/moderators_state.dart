part of 'moderators_cubit.dart';

@immutable
sealed class ModeratorsState {}

final class ModeratorsInitial extends ModeratorsState {}

class PickedSwitchState extends ModeratorsState {}

class GetModeratorsLoading extends ModeratorsState {}
class GetModeratorsSuccess extends ModeratorsState {}
class GetModeratorsFailure extends ModeratorsState {}

class GetTabAccessLoading extends ModeratorsState {}
class GetTabAccessSuccess extends ModeratorsState {}
class GetTabAccessFailure extends ModeratorsState {}

class RegisterLoading extends ModeratorsState {}
class RegisterSuccess extends ModeratorsState {}
class RegisterFailure extends ModeratorsState {}

class UpdateAccountLoading extends ModeratorsState {}
class UpdateAccountSuccess extends ModeratorsState {}
class UpdateAccountFailure extends ModeratorsState {}

class CreateAccessLoading extends ModeratorsState {}
class CreateAccessSuccess extends ModeratorsState {}
class CreateAccessFailure extends ModeratorsState {}

class UpdateAccessLoading extends ModeratorsState {}
class UpdateAccessSuccess extends ModeratorsState {}
class UpdateAccessFailure extends ModeratorsState {}

class ActivateAccountLoading extends ModeratorsState {}
class ActivateAccountSuccess extends ModeratorsState {}
class ActivateAccountFailure extends ModeratorsState {}

class StopAccountLoading extends ModeratorsState {}
class StopAccountSuccess extends ModeratorsState {}
class StopAccountFailure extends ModeratorsState {}

class DeleteAccountLoading extends ModeratorsState {}
class DeleteAccountSuccess extends ModeratorsState {}
class DeleteAccountFailure extends ModeratorsState {}

class UserAdminCommentLoading extends ModeratorsState {}
class UserAdminCommentSuccess extends ModeratorsState {}
class UserAdminCommentFailure extends ModeratorsState {}
