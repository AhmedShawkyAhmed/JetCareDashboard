part of 'states_cubit.dart';

@immutable
abstract class StatesState {}

class StatesInitial extends StatesState {}

class GetStatesLoading extends StatesState {}
class GetStatesSuccess extends StatesState {}
class GetStatesError extends StatesState {}

class AddStatesLoading extends StatesState {}
class AddStatesSuccess extends StatesState {}
class AddStatesError extends StatesState {}

class DeleteStatesLoading extends StatesState {}
class DeleteStatesSuccess extends StatesState {}
class DeleteStatesError extends StatesState {}

class UpdateStatesLoading extends StatesState {}
class UpdateStatesSuccess extends StatesState {}
class UpdateStatesError extends StatesState {}

class ChangeStatesLoading extends StatesState {}
class ChangeStatesSuccess extends StatesState {}
class ChangeStatesError extends StatesState {}

class PickedSwitchState extends StatesState {}
