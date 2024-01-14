part of 'clients_cubit.dart';

@immutable
abstract class ClientsState {}

class UsersCubitInitial extends ClientsState {}

class UserSwitchState extends ClientsState {}

class UserLoadingState extends ClientsState {}

class UserSuccessState extends ClientsState {}

class UserErrorState extends ClientsState {}

class UserTypeLoadingState extends ClientsState {}

class UserTypeSuccessState extends ClientsState {}

class UserTypeErrorState extends ClientsState {}

class ChangeUserLoadingState extends ClientsState {}

class ChangeUserSuccessState extends ClientsState {}

class ChangeUserErrorState extends ClientsState {}

class AddUserLoadingState extends ClientsState {}

class AddUserSuccessState extends ClientsState {}

class AddUserErrorState extends ClientsState {}

class UpdateUserLoadingState extends ClientsState {}

class UpdateUserSuccessState extends ClientsState {}

class UpdateUserErrorState extends ClientsState {}

class DeleteUserLoadingState extends ClientsState {}

class DeleteUserSuccessState extends ClientsState {}

class DeleteUserErrorState extends ClientsState {}

class RoleUserLoadingState extends ClientsState {}

class RoleUserSuccessState extends ClientsState {}

class RoleUserErrorState extends ClientsState {}

class ChangePasswordState extends ClientsState {}

class UserCommentLoadingState extends ClientsState {}
class UserCommentSuccessState extends ClientsState {}
class UserCommentErrorState extends ClientsState {}

