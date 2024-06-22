part of 'states_cubit.dart';

@immutable
sealed class StatesState {}

final class StatesInitial extends StatesState {}

class PickedSwitchState extends StatesState {}

class GetStatesLoading extends StatesState {}
class GetStatesSuccess extends StatesState {}
class GetStatesFailure extends StatesState {}

class AddStateLoading extends StatesState {}
class AddStateSuccess extends StatesState {}
class AddStateFailure extends StatesState {}

class UpdateStateLoading extends StatesState {}
class UpdateStateSuccess extends StatesState {}
class UpdateStateFailure extends StatesState {}

class ChangeStateStatusLoading extends StatesState {}
class ChangeStateStatusSuccess extends StatesState {}
class ChangeStateStatusFailure extends StatesState {}

class DeleteStateLoading extends StatesState {}
class DeleteStateSuccess extends StatesState {}
class DeleteStateFailure extends StatesState {}
