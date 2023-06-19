part of 'corporate_item_cubit.dart';

@immutable
abstract class CorporateItemState {}

class CorporateItemInitial extends CorporateItemState {}

class AdsSwitchState extends CorporateItemState {}

class ItemsLoadingState extends CorporateItemState {}
class ItemsSuccessState extends CorporateItemState {}
class ItemsErrorState extends CorporateItemState {}

class AddItemsLoadingState extends CorporateItemState {}
class AddItemsSuccessState extends CorporateItemState {}
class AddItemsErrorState extends CorporateItemState {}

class DeleteItemsLoadingState extends CorporateItemState {}
class DeleteItemsSuccessState extends CorporateItemState {}
class DeleteItemsErrorState extends CorporateItemState {}

class ChangeItemsLoadingState extends CorporateItemState {}
class ChangeItemsSuccessState extends CorporateItemState {}
class ChangeItemsErrorState extends CorporateItemState {}

class UpdateLoadingState extends CorporateItemState {}
class UpdateSuccessState extends CorporateItemState {}
class UpdateErrorState extends CorporateItemState {}

class ItemsPickedImageLoadingState extends CorporateItemState {}
class ItemsPickedImageSuccessState extends CorporateItemState {}
