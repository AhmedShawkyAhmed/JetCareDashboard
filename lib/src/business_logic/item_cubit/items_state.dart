part of 'items_cubit.dart';

@immutable
abstract class ItemsState {}

class ItemsCubitInitial extends ItemsState {}

class AdsSwitchState extends ItemsState {}
class ItemsLoadingState extends ItemsState {}
class ItemsSuccessState extends ItemsState {}
class ItemsErrorState extends ItemsState {}

class ItemsForPackagesLoadingState extends ItemsState {}
class ItemsForPackagesSuccessState extends ItemsState {}
class ItemsForPackagesErrorState extends ItemsState {}

class ChangeItemsLoadingState extends ItemsState {}
class ChangeItemsSuccessState extends ItemsState {}
class ChangeItemsErrorState extends ItemsState {}

class UpdateLoadingState extends ItemsState {}
class UpdateSuccessState extends ItemsState {}
class UpdateErrorState extends ItemsState {}

class AddItemsLoadingState extends ItemsState {}
class AddItemsSuccessState extends ItemsState {}
class AddItemsErrorState extends ItemsState {}

class DeleteItemsLoadingState extends ItemsState {}
class DeleteItemsSuccessState extends ItemsState {}
class DeleteItemsErrorState extends ItemsState {}

class ItemsTypeLoadingState extends ItemsState {}
class ItemsTypeSuccessState extends ItemsState {}
class ItemsTypeErrorState extends ItemsState {}

class ItemsPickedImageLoadingState extends ItemsState {}
class ItemsPickedImageSuccessState extends ItemsState {}
