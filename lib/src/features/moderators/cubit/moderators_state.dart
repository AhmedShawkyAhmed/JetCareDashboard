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

class AddModeratorLoading extends ModeratorsState {}
class AddModeratorSuccess extends ModeratorsState {}
class AddModeratorFailure extends ModeratorsState {}

class UpdateModeratorLoading extends ModeratorsState {}
class UpdateModeratorSuccess extends ModeratorsState {}
class UpdateModeratorFailure extends ModeratorsState {}

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

class DeleteModeratorLoading extends ModeratorsState {}
class DeleteModeratorSuccess extends ModeratorsState {}
class DeleteModeratorFailure extends ModeratorsState {}

class UserAdminCommentLoading extends ModeratorsState {}
class UserAdminCommentSuccess extends ModeratorsState {}
class UserAdminCommentFailure extends ModeratorsState {}
