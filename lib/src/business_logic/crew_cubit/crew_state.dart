part of 'crew_cubit.dart';

@immutable
abstract class CrewState {}

class CrewInitial extends CrewState {}

class ChangePasswordState extends CrewState {}
class CrewSwitchState extends CrewState {}

class CrewAreaLoading extends CrewState {}
class CrewAreaSuccess extends CrewState {}
class CrewAreaError extends CrewState {}

class AddCrewAreaLoading extends CrewState {}
class AddCrewAreaSuccess extends CrewState {}
class AddCrewAreaError extends CrewState {}

class DeleteCrewAreaLoading extends CrewState {}
class DeleteCrewAreaSuccess extends CrewState {}
class DeleteCrewAreaError extends CrewState {}

class CrewLoadingState extends CrewState {}
class CrewSuccessState extends CrewState {}
class CrewErrorState extends CrewState {}

class ChangeCrewLoadingState extends CrewState {}
class ChangeCrewSuccessState extends CrewState {}
class ChangeCrewErrorState extends CrewState {}

class AddCrewLoadingState extends CrewState {}
class AddCrewSuccessState extends CrewState {}
class AddCrewErrorState extends CrewState {}

class UpdateCrewLoadingState extends CrewState {}
class UpdateCrewSuccessState extends CrewState {}
class UpdateCrewErrorState extends CrewState {}

class DeleteCrewLoadingState extends CrewState {}
class DeleteCrewSuccessState extends CrewState {}
class DeleteCrewErrorState extends CrewState {}

class CrewCommentLoadingState extends CrewState {}
class CrewCommentSuccessState extends CrewState {}
class CrewCommentErrorState extends CrewState {}
