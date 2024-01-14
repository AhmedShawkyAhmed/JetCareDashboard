part of 'equipment_schedule_cubit.dart';

@immutable
abstract class EquipmentScheduleState {}

class EquipmentInitial extends EquipmentScheduleState {}

class GetEquipmentLoadingState extends EquipmentScheduleState {}
class GetEquipmentSuccessState extends EquipmentScheduleState {}
class GetEquipmentErrorState extends EquipmentScheduleState {}

class AddEquipmentLoadingState extends EquipmentScheduleState {}
class AddEquipmentSuccessState extends EquipmentScheduleState {}
class AddEquipmentErrorState extends EquipmentScheduleState {}

class AddEquipmentReturnedDateLoadingState extends EquipmentScheduleState {}
class AddEquipmentReturnedDateSuccessState extends EquipmentScheduleState {}
class AddEquipmentReturnedDateErrorState extends EquipmentScheduleState {}

class ReturnEquipmentLoadingState extends EquipmentScheduleState {}
class ReturnEquipmentSuccessState extends EquipmentScheduleState {}
class ReturnEquipmentErrorState extends EquipmentScheduleState {}

class DeleteEquipmentLoadingState extends EquipmentScheduleState {}
class DeleteEquipmentSuccessState extends EquipmentScheduleState {}
class DeleteEquipmentErrorState extends EquipmentScheduleState {}

class AssignEquipmentLoadingState extends EquipmentScheduleState {}
class AssignEquipmentSuccessState extends EquipmentScheduleState {}
class AssignEquipmentErrorState extends EquipmentScheduleState {}
