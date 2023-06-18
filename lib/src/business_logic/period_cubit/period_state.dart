part of 'period_cubit.dart';

@immutable
abstract class PeriodState {}

class PeriodInitial extends PeriodState {}

class PickedSwitchState extends PeriodState {}

class PeriodLoadingState extends PeriodState {}

class PeriodSuccessState extends PeriodState {}

class PeriodErrorState extends PeriodState {}

class AddPeriodLoadingState extends PeriodState {}

class AddPeriodSuccessState extends PeriodState {}

class AddPeriodErrorState extends PeriodState {}

class UpdatePeriodLoadingState extends PeriodState {}

class UpdatePeriodSuccessState extends PeriodState {}

class UpdatePeriodErrorState extends PeriodState {}

class ChangePeriodLoadingState extends PeriodState {}

class ChangePeriodSuccessState extends PeriodState {}

class ChangePeriodErrorState extends PeriodState {}

class DeletePeriodLoadingState extends PeriodState {}

class DeletePeriodSuccessState extends PeriodState {}

class DeletePeriodErrorState extends PeriodState {}
