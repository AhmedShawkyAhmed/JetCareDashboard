part of 'users_cubit.dart';

@immutable
abstract class UsersState {}

class UsersCubitInitial extends UsersState {}

class UserSwitchState extends UsersState {}

class UserLoadingState extends UsersState {}

class UserSuccessState extends UsersState {}

class UserErrorState extends UsersState {}

class UserTypeLoadingState extends UsersState {}

class UserTypeSuccessState extends UsersState {}

class UserTypeErrorState extends UsersState {}

class ChangeUserLoadingState extends UsersState {}

class ChangeUserSuccessState extends UsersState {}

class ChangeUserErrorState extends UsersState {}

class AddUserLoadingState extends UsersState {}

class AddUserSuccessState extends UsersState {}

class AddUserErrorState extends UsersState {}

class UpdateUserLoadingState extends UsersState {}

class UpdateUserSuccessState extends UsersState {}

class UpdateUserErrorState extends UsersState {}

class DeleteUserLoadingState extends UsersState {}

class DeleteUserSuccessState extends UsersState {}

class DeleteUserErrorState extends UsersState {}

class RoleUserLoadingState extends UsersState {}

class RoleUserSuccessState extends UsersState {}

class RoleUserErrorState extends UsersState {}

class ChangePasswordState extends UsersState {}

class UserCommentLoadingState extends UsersState {}
class UserCommentSuccessState extends UsersState {}
class UserCommentErrorState extends UsersState {}

