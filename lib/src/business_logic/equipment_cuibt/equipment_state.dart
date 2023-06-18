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

class DeleteEquipmentLoadingState extends EquipmentState {}
class DeleteEquipmentSuccessState extends EquipmentState {}
class DeleteEquipmentErrorState extends EquipmentState {}

