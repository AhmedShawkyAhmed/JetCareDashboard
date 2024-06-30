part of 'items_cubit.dart';

@immutable
sealed class ItemsState {}

final class ItemsInitial extends ItemsState {}

class PickedSwitchState extends ItemsState {}

class ItemPickedImageLoading extends ItemsState {}
class ItemPickedImageSuccess extends ItemsState {}

class GetItemsLoading extends ItemsState {}
class GetItemsSuccess extends ItemsState {}
class GetItemsFailure extends ItemsState {}

class GetCorporateLoading extends ItemsState {}
class GetCorporateSuccess extends ItemsState {}
class GetCorporateFailure extends ItemsState {}

class GetExtrasLoading extends ItemsState {}
class GetExtrasSuccess extends ItemsState {}
class GetExtrasFailure extends ItemsState {}

class AddItemLoading extends ItemsState {}
class AddItemSuccess extends ItemsState {}
class AddItemFailure extends ItemsState {}

class UpdateItemLoading extends ItemsState {}
class UpdateItemSuccess extends ItemsState {}
class UpdateItemFailure extends ItemsState {}

class ChangeItemStatusLoading extends ItemsState {}
class ChangeItemStatusSuccess extends ItemsState {}
class ChangeItemStatusFailure extends ItemsState {}

class DeleteItemLoading extends ItemsState {}
class DeleteItemSuccess extends ItemsState {}
class DeleteItemFailure extends ItemsState {}
