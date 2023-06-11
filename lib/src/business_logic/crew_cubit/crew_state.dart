part of 'crew_cubit.dart';

@immutable
abstract class CrewState {}

class CrewInitial extends CrewState {}

class CrewAreaLoading extends CrewState {}
class CrewAreaSuccess extends CrewState {}
class CrewAreaError extends CrewState {}

class AddCrewAreaLoading extends CrewState {}
class AddCrewAreaSuccess extends CrewState {}
class AddCrewAreaError extends CrewState {}

class DeleteCrewAreaLoading extends CrewState {}
class DeleteCrewAreaSuccess extends CrewState {}
class DeleteCrewAreaError extends CrewState {}
