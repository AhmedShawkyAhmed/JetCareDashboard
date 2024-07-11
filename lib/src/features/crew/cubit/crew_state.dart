part of 'crew_cubit.dart';

@immutable
sealed class CrewState {}

final class CrewInitial extends CrewState {}

class PickedSwitchState extends CrewState {}

class GetCrewLoading extends CrewState {}
class GetCrewSuccess extends CrewState {}
class GetCrewFailure extends CrewState {}

class AddCrewLoading extends CrewState {}
class AddCrewSuccess extends CrewState {}
class AddCrewFailure extends CrewState {}

class UpdateCrewLoading extends CrewState {}
class UpdateCrewSuccess extends CrewState {}
class UpdateCrewFailure extends CrewState {}

class ActivateAccountLoading extends CrewState {}
class ActivateAccountSuccess extends CrewState {}
class ActivateAccountFailure extends CrewState {}

class StopAccountLoading extends CrewState {}
class StopAccountSuccess extends CrewState {}
class StopAccountFailure extends CrewState {}

class DeleteCrewLoading extends CrewState {}
class DeleteCrewSuccess extends CrewState {}
class DeleteCrewFailure extends CrewState {}

class UserAdminCommentLoading extends CrewState {}
class UserAdminCommentSuccess extends CrewState {}
class UserAdminCommentFailure extends CrewState {}

class GetCrewAreaLoading extends CrewState {}
class GetCrewAreaSuccess extends CrewState {}
class GetCrewAreaFailure extends CrewState {}

class GetCrewOfAreasLoading extends CrewState {}
class GetCrewOfAreasSuccess extends CrewState {}
class GetCrewOfAreasFailure extends CrewState {}

class AddCrewAreaLoading extends CrewState {}
class AddCrewAreaSuccess extends CrewState {}
class AddCrewAreaFailure extends CrewState {}

class DeleteCrewAreaLoading extends CrewState {}
class DeleteCrewAreaSuccess extends CrewState {}
class DeleteCrewAreaFailure extends CrewState {}
