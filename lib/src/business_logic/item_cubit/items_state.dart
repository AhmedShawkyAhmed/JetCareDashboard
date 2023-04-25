part of 'items_cubit.dart';

@immutable
abstract class ItemsState {}

class ItemsCubitInitial extends ItemsState {}

class AdsSwitchState extends ItemsState {}

class ItemsLodingState extends ItemsState {}

class ItemsSuccessState extends ItemsState {}

class ItemsErrorState extends ItemsState {}

class ItemsForPackagesLodingState extends ItemsState {}

class ItemsForPackagesSuccessState extends ItemsState {}

class ItemsForPackagesErrorState extends ItemsState {}

class ChangeItemsLodingState extends ItemsState {}

class ChangeItemsSuccessState extends ItemsState {}

class ChangeItemsErrorState extends ItemsState {}

class AddItemsLodingState extends ItemsState {}

class AddItemsSuccessState extends ItemsState {}

class AddItemsErrorState extends ItemsState {}

class DeleteItemsLodingState extends ItemsState {}

class DeleteItemsSuccessState extends ItemsState {}

class DeleteItemsErrorState extends ItemsState {}

class ItemsTypeLodingState extends ItemsState {}

class ItemsTypeSuccessState extends ItemsState {}

class ItemsTypeErrorState extends ItemsState {}

class UpdateLodingState extends ItemsState {}

class UpdateSuccessState extends ItemsState {}

class UpdateErrorState extends ItemsState {}

class ItemsPickedImageLodindState extends ItemsState {}

class ItemsPickedImageSuccessState extends ItemsState {}
