part of 'extras_cubit.dart';

@immutable
abstract class ExtrasState {}

class ExtrasInitial extends ExtrasState {}

class AdsSwitchState extends ExtrasState {}

class ItemsLoadingState extends ExtrasState {}
class ItemsSuccessState extends ExtrasState {}
class ItemsErrorState extends ExtrasState {}

class AddItemsLoadingState extends ExtrasState {}
class AddItemsSuccessState extends ExtrasState {}
class AddItemsErrorState extends ExtrasState {}

class DeleteItemsLoadingState extends ExtrasState {}
class DeleteItemsSuccessState extends ExtrasState {}
class DeleteItemsErrorState extends ExtrasState {}

class ChangeItemsLoadingState extends ExtrasState {}
class ChangeItemsSuccessState extends ExtrasState {}
class ChangeItemsErrorState extends ExtrasState {}

class UpdateLoadingState extends ExtrasState {}
class UpdateSuccessState extends ExtrasState {}
class UpdateErrorState extends ExtrasState {}

class ItemsPickedImageLoadingState extends ExtrasState {}
class ItemsPickedImageSuccessState extends ExtrasState {}
