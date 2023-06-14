part of 'equipment_cubit.dart';

@immutable
abstract class EquipmentState {}

class EquipmentInitial extends EquipmentState {}

class GetEquipmentLoadingState extends EquipmentState {}
class GetEquipmentSuccessState extends EquipmentState {}
class GetEquipmentErrorState extends EquipmentState {}

class AddEquipmentLoadingState extends EquipmentState {}
class AddEquipmentSuccessState extends EquipmentState {}
class AddEquipmentErrorState extends EquipmentState {}

class ReturnEquipmentLoadingState extends EquipmentState {}
class ReturnEquipmentSuccessState extends EquipmentState {}
class ReturnEquipmentErrorState extends EquipmentState {}

class DeleteEquipmentLoadingState extends EquipmentState {}
class DeleteEquipmentSuccessState extends EquipmentState {}
class DeleteEquipmentErrorState extends EquipmentState {}

class AssignEquipmentLoadingState extends EquipmentState {}
class AssignEquipmentSuccessState extends EquipmentState {}
class AssignEquipmentErrorState extends EquipmentState {}
