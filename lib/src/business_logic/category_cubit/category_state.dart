part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategorySuccessState extends CategoryState {}

class CategoryErrorState extends CategoryState {}

class CategoryPackagesLoadingState extends CategoryState {}

class CategoryPackagesSuccessState extends CategoryState {}

class CategoryPackagesErrorState extends CategoryState {}

class CategoryItemsLoadingState extends CategoryState {}

class CategoryItemsSuccessState extends CategoryState {}

class CategoryItemsErrorState extends CategoryState {}

class AddCategoryLoadingState extends CategoryState {}

class AddCategorySuccessState extends CategoryState {}

class AddCategoryErrorState extends CategoryState {}

class UpdateCategoryLoadingState extends CategoryState {}

class UpdateCategorySuccessState extends CategoryState {}

class UpdateCategoryErrorState extends CategoryState {}

class ChangeCategoryLoadingState extends CategoryState {}

class ChangeCategorySuccessState extends CategoryState {}

class ChangeCategoryErrorState extends CategoryState {}

class AddPackagesCategoryLoadingState extends CategoryState {}

class AddPackagesCategorySuccessState extends CategoryState {}

class AddPackagesCategoryErrorState extends CategoryState {}

class AddItemsCategoryLoadingState extends CategoryState {}

class AddItemsCategorySuccessState extends CategoryState {}

class AddItemsCategoryErrorState extends CategoryState {}

class DeletePackagesCategoryLoadingState extends CategoryState {}

class DeletePackagesCategorySuccessState extends CategoryState {}

class DeletePackagesCategoryErrorState extends CategoryState {}

class PickedImageLodindState extends CategoryState {}

class PickedImageSuccessState extends CategoryState {}

class PickedSwitchState extends CategoryState {}

class DeeleteCategoryLoadingState extends CategoryState {}

class DeeleteCategorySuccessState extends CategoryState {}

class DeeleteCategoryErrorState extends CategoryState {}
