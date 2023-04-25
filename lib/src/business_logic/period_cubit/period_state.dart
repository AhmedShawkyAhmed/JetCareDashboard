part of 'period_cubit.dart';

@immutable
abstract class PeriodState {}

class PeriodInitial extends PeriodState {}

class PickedSwitchState extends PeriodState {}

class PeriodLodingState extends PeriodState {}

class PeriodSuccessState extends PeriodState {}

class PeriodErrorState extends PeriodState {}

class AddPeriodLodingState extends PeriodState {}

class AddPeriodSuccessState extends PeriodState {}

class AddPeriodErrorState extends PeriodState {}

class UpdatePeriodLodingState extends PeriodState {}

class UpdatePeriodSuccessState extends PeriodState {}

class UpdatePeriodErrorState extends PeriodState {}

class ChangePeriodLodingState extends PeriodState {}

class ChangePeriodSuccessState extends PeriodState {}

class ChangePeriodErrorState extends PeriodState {}

class DeletePeriodLodingState extends PeriodState {}

class DeletePeriodSuccessState extends PeriodState {}

class DeletePeriodErrorState extends PeriodState {}
