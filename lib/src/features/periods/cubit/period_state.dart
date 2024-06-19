part of 'period_cubit.dart';

@immutable
sealed class PeriodState {}

final class PeriodInitial extends PeriodState {}

class PickedSwitchState extends PeriodState {}

class GetPeriodLoading extends PeriodState {}
class GetPeriodSuccess extends PeriodState {}
class GetPeriodFailure extends PeriodState {}

class AddPeriodLoading extends PeriodState {}
class AddPeriodSuccess extends PeriodState {}
class AddPeriodFailure extends PeriodState {}

class UpdatePeriodLoading extends PeriodState {}
class UpdatePeriodSuccess extends PeriodState {}
class UpdatePeriodFailure extends PeriodState {}

class DeletePeriodLoading extends PeriodState {}
class DeletePeriodSuccess extends PeriodState {}
class DeletePeriodFailure extends PeriodState {}

class ChangeStatusPeriodLoading extends PeriodState {}
class ChangeStatusPeriodSuccess extends PeriodState {}
class ChangeStatusPeriodFailure extends PeriodState {}
