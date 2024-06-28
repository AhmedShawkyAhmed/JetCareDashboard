part of 'equipment_cubit.dart';

@immutable
sealed class EquipmentState {}

final class EquipmentInitial extends EquipmentState {}

class GetEquipmentLoading extends EquipmentState {}
class GetEquipmentSuccess extends EquipmentState {}
class GetEquipmentFailure extends EquipmentState {}

class AddEquipmentLoading extends EquipmentState {}
class AddEquipmentSuccess extends EquipmentState {}
class AddEquipmentFailure extends EquipmentState {}

class DeleteEquipmentLoading extends EquipmentState {}
class DeleteEquipmentSuccess extends EquipmentState {}
class DeleteEquipmentFailure extends EquipmentState {}
