part of 'equipment_schedule_cubit.dart';

@immutable
sealed class EquipmentScheduleState {}

final class EquipmentScheduleInitial extends EquipmentScheduleState {}

class GetEquipmentScheduleLoading extends EquipmentScheduleState {}
class GetEquipmentScheduleSuccess extends EquipmentScheduleState {}
class GetEquipmentScheduleFailure extends EquipmentScheduleState {}

class AssignEquipmentLoading extends EquipmentScheduleState {}
class AssignEquipmentSuccess extends EquipmentScheduleState {}
class AssignEquipmentFailure extends EquipmentScheduleState {}

class ReturnEquipmentLoading extends EquipmentScheduleState {}
class ReturnEquipmentSuccess extends EquipmentScheduleState {}
class ReturnEquipmentFailure extends EquipmentScheduleState {}
