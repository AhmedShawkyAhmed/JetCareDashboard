part of 'users_cubit.dart';

@immutable
abstract class UsersState {}

class UsersCubitInitial extends UsersState {}

class UserSwitchState extends UsersState {}

class UserLodingState extends UsersState {}

class UserSuccessState extends UsersState {}

class UserErrorState extends UsersState {}

class UserTypeLodingState extends UsersState {}

class UserTypeSuccessState extends UsersState {}

class UserTypeErrorState extends UsersState {}

class ChangeUserLodingState extends UsersState {}

class ChangeUserSuccessState extends UsersState {}

class ChangeUserErrorState extends UsersState {}

class AddUserLodingState extends UsersState {}

class AddUserSuccessState extends UsersState {}

class AddUserErrorState extends UsersState {}

class UpdateUserLodingState extends UsersState {}

class UpdateUserSuccessState extends UsersState {}

class UpdateUserErrorState extends UsersState {}

class DeleteUserLodingState extends UsersState {}

class DeleteUserSuccessState extends UsersState {}

class DeleteUserErrorState extends UsersState {}

class RoleUserLodingState extends UsersState {}

class RoleUserSuccessState extends UsersState {}

class RoleUserErrorState extends UsersState {}

class ChangePasswordState extends UsersState {}

