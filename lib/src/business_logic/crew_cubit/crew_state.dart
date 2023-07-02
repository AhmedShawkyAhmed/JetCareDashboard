part of 'crew_cubit.dart';

@immutable
abstract class CrewState {}

class CrewInitial extends CrewState {}

class ChangePasswordState extends CrewState {}
class UserSwitchState extends CrewState {}

class CrewAreaLoading extends CrewState {}
class CrewAreaSuccess extends CrewState {}
class CrewAreaError extends CrewState {}

class AddCrewAreaLoading extends CrewState {}
class AddCrewAreaSuccess extends CrewState {}
class AddCrewAreaError extends CrewState {}

class DeleteCrewAreaLoading extends CrewState {}
class DeleteCrewAreaSuccess extends CrewState {}
class DeleteCrewAreaError extends CrewState {}

class UserLoadingState extends CrewState {}
class UserSuccessState extends CrewState {}
class UserErrorState extends CrewState {}

class ChangeUserLoadingState extends CrewState {}
class ChangeUserSuccessState extends CrewState {}
class ChangeUserErrorState extends CrewState {}

class AddUserLoadingState extends CrewState {}
class AddUserSuccessState extends CrewState {}
class AddUserErrorState extends CrewState {}

class UpdateUserLoadingState extends CrewState {}
class UpdateUserSuccessState extends CrewState {}
class UpdateUserErrorState extends CrewState {}

class DeleteUserLoadingState extends CrewState {}
class DeleteUserSuccessState extends CrewState {}
class DeleteUserErrorState extends CrewState {}

class UserCommentLoadingState extends CrewState {}
class UserCommentSuccessState extends CrewState {}
class UserCommentErrorState extends CrewState {}
