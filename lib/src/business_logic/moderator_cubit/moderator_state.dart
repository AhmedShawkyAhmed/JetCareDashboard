part of 'moderator_cubit.dart';

@immutable
abstract class ModeratorState {}

class ModeratorInitial extends ModeratorState {}

class ChangePasswordState extends ModeratorState {}
class UserSwitchState extends ModeratorState {}

class UserLoadingState extends ModeratorState {}
class UserSuccessState extends ModeratorState {}
class UserErrorState extends ModeratorState {}

class ChangeUserLoadingState extends ModeratorState {}
class ChangeUserSuccessState extends ModeratorState {}
class ChangeUserErrorState extends ModeratorState {}

class AddUserLoadingState extends ModeratorState {}
class AddUserSuccessState extends ModeratorState {}
class AddUserErrorState extends ModeratorState {}

class UpdateUserLoadingState extends ModeratorState {}
class UpdateUserSuccessState extends ModeratorState {}
class UpdateUserErrorState extends ModeratorState {}

class DeleteUserLoadingState extends ModeratorState {}
class DeleteUserSuccessState extends ModeratorState {}
class DeleteUserErrorState extends ModeratorState {}

class CreateAccessLoadingState extends ModeratorState {}
class CreateAccessSuccessState extends ModeratorState {}
class CreateAccessErrorState extends ModeratorState {}

class UpdateAccessLoadingState extends ModeratorState {}
class UpdateAccessSuccessState extends ModeratorState {}
class UpdateAccessErrorState extends ModeratorState {}

class GetAccessLoadingState extends ModeratorState {}
class GetAccessSuccessState extends ModeratorState {}
class GetAccessErrorState extends ModeratorState {}

class UserCommentLoadingState extends ModeratorState {}
class UserCommentSuccessState extends ModeratorState {}
class UserCommentErrorState extends ModeratorState {}
