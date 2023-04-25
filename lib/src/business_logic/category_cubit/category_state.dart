part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLodingState extends CategoryState {}

class CategorySuccessState extends CategoryState {}

class CategoryErrorState extends CategoryState {}

class CategoryPackagesLodingState extends CategoryState {}

class CategoryPackagesSuccessState extends CategoryState {}

class CategoryPackagesErrorState extends CategoryState {}

class CategoryItemsLodingState extends CategoryState {}

class CategoryItemsSuccessState extends CategoryState {}

class CategoryItemsErrorState extends CategoryState {}

class AddCategoryLodingState extends CategoryState {}

class AddCategorySuccessState extends CategoryState {}

class AddCategoryErrorState extends CategoryState {}

class UpdateCategoryLodingState extends CategoryState {}

class UpdateCategorySuccessState extends CategoryState {}

class UpdateCategoryErrorState extends CategoryState {}

class ChangeCategoryLodingState extends CategoryState {}

class ChangeCategorySuccessState extends CategoryState {}

class ChangeCategoryErrorState extends CategoryState {}

class AddPackagesCategoryLodingState extends CategoryState {}

class AddPackagesCategorySuccessState extends CategoryState {}

class AddPackagesCategoryErrorState extends CategoryState {}

class AddItemsCategoryLodingState extends CategoryState {}

class AddItemsCategorySuccessState extends CategoryState {}

class AddItemsCategoryErrorState extends CategoryState {}

class DeletePackagesCategoryLodingState extends CategoryState {}

class DeletePackagesCategorySuccessState extends CategoryState {}

class DeletePackagesCategoryErrorState extends CategoryState {}

class PickedImageLodindState extends CategoryState {}

class PickedImageSuccessState extends CategoryState {}

class PickedSwitchState extends CategoryState {}

class DeeleteCategoryLodingState extends CategoryState {}

class DeeleteCategorySuccessState extends CategoryState {}

class DeeleteCategoryErrorState extends CategoryState {}
