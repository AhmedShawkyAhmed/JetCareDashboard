part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

class PickedSwitchState extends CategoriesState {}

class CategoryPickedImageLoading extends CategoriesState {}
class CategoryPickedImageSuccess extends CategoriesState {}

class GetCategoriesLoading extends CategoriesState {}
class GetCategoriesSuccess extends CategoriesState {}
class GetCategoriesFailure extends CategoriesState {}

class GetCategoryDetailsLoading extends CategoriesState {}
class GetCategoryDetailsSuccess extends CategoriesState {}
class GetCategoryDetailsFailure extends CategoriesState {}

class AddCategoryLoading extends CategoriesState {}
class AddCategorySuccess extends CategoriesState {}
class AddCategoryFailure extends CategoriesState {}

class UpdateCategoryLoading extends CategoriesState {}
class UpdateCategorySuccess extends CategoriesState {}
class UpdateCategoryFailure extends CategoriesState {}

class ChangeCategoryStatusLoading extends CategoriesState {}
class ChangeCategoryStatusSuccess extends CategoriesState {}
class ChangeCategoryStatusFailure extends CategoriesState {}

class DeleteCategoryLoading extends CategoriesState {}
class DeleteCategorySuccess extends CategoriesState {}
class DeleteCategoryFailure extends CategoriesState {}

class AddCategoryPackagesLoading extends CategoriesState {}
class AddCategoryPackagesSuccess extends CategoriesState {}
class AddCategoryPackagesFailure extends CategoriesState {}

class AddCategoryItemsLoading extends CategoriesState {}
class AddCategoryItemsSuccess extends CategoriesState {}
class AddCategoryItemsFailure extends CategoriesState {}

class DeleteCategoryItemLoading extends CategoriesState {}
class DeleteCategoryItemSuccess extends CategoriesState {}
class DeleteCategoryItemFailure extends CategoriesState {}
