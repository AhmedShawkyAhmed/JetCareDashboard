import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/categories/data/models/category_model.dart';
import 'package:jetboard/src/features/categories/data/repo/categories_repo.dart';
import 'package:jetboard/src/features/categories/data/requests/category_item_request.dart';
import 'package:jetboard/src/features/categories/data/requests/category_request.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.repo) : super(CategoriesInitial());
  final CategoriesRepo repo;

  List<CategoryModel>? categories;
  CategoryModel? categoryDetails;
  FilePickerResult? fileResult;

  Future pickImage() async {
    emit(CategoryPickedImageLoading());
    try {
      fileResult = await FilePicker.platform.pickFiles();
    } catch (e) {
      printError(e.toString());
    }
    if (fileResult != null) {
      emit(CategoryPickedImageSuccess());
      printSuccess(fileResult!.files.first.name.toString());
    }
  }

  Future switched(CategoryModel category) async {
    await changeCategoryStatus(
      request: CategoryRequest(
        id: category.id,
        isActive: !category.isActive!,
      ),
    );
    emit(PickedSwitchState());
  }

  Future getCategories({
    String? keyword,
  }) async {
    emit(GetCategoriesLoading());
    var response = await repo.getCategories(
      keyword: keyword,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        categories = response.data;
        emit(GetCategoriesSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetCategoriesFailure());
        error.showError();
      },
    );
  }

  Future getCategoryDetails({
    required int id,
  }) async {
    emit(GetCategoryDetailsLoading());
    var response = await repo.getCategoryDetails(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        categoryDetails = response.data;
        emit(GetCategoryDetailsSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetCategoryDetailsFailure());
        error.showError();
      },
    );
  }

  Future addCategory({
    required CategoryRequest request,
  }) async {
    emit(AddCategoryLoading());
    var response = await repo.addCategory(
      request: request,
      image: File(fileResult!.files.first.name.toString()),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (categories != null) {
          categories!.add(response.data);
        }
        emit(AddCategorySuccess());
        NavigationService.pop();
      },
      failure: (NetworkExceptions error) {
        emit(AddCategoryFailure());
        error.showError();
      },
    );
  }

  Future updateCategory({
    required CategoryRequest request,
  }) async {
    emit(UpdateCategoryLoading());
    var response = await repo.updateCategory(
      request: request,
      image: File(fileResult?.files.first.name ?? ""),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        CategoryModel? category =
        categories!.firstWhere((category) => category.id == request.id);
        category.nameAr = request.nameAr;
        category.nameEn = request.nameEn;
        category.descriptionAr = request.descriptionAr;
        category.descriptionEn = request.descriptionEn;
        category.image = File(fileResult?.files.first.name ?? "").path;
        emit(UpdateCategorySuccess());
      },
      failure: (NetworkExceptions error) {
        emit(UpdateCategoryFailure());
        error.showError();
      },
    );
  }

  Future changeCategoryStatus({
    required CategoryRequest request,
  }) async {
    emit(UpdateCategoryLoading());
    var response = await repo.changeCategoryStatus(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (categories != null) {
          categories!.firstWhere((category) => category.id == request.id).isActive =
              request.isActive;
        }
        emit(UpdateCategorySuccess());
      },
      failure: (NetworkExceptions error) {
        emit(UpdateCategoryFailure());
        error.showError();
      },
    );
  }

  Future deleteCategory({
    required int id,
  }) async {
    emit(DeleteCategoryLoading());
    var response = await repo.deleteCategory(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (categories != null) {
          categories!.removeWhere((category) => category.id == id);
        }
        emit(DeleteCategorySuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeleteCategoryFailure());
        error.showError();
      },
    );
  }

  Future addCategoryPackage({
    required CategoryItemRequest request,
  }) async {
    emit(AddCategoryPackagesLoading());
    var response = await repo.addCategoryPackage(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(AddCategoryPackagesSuccess());
        NavigationService.pop();
      },
      failure: (NetworkExceptions error) {
        emit(AddCategoryPackagesFailure());
        error.showError();
      },
    );
  }

  Future addCategoryItem({
    required CategoryItemRequest request,
  }) async {
    emit(AddCategoryItemsLoading());
    var response = await repo.addCategoryItem(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(AddCategoryItemsSuccess());
        NavigationService.pop();
      },
      failure: (NetworkExceptions error) {
        emit(AddCategoryItemsFailure());
        error.showError();
      },
    );
  }

  Future deleteCategoryPackage({
    required int id,
  }) async {
    emit(DeleteCategoryItemLoading());
    var response = await repo.deleteCategorySub(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (categoryDetails?.packages != null) {
          categoryDetails!.packages!.removeWhere((category) => category.id == id);
        }

        emit(DeleteCategoryItemSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeleteCategoryItemFailure());
        error.showError();
      },
    );
  }

  Future deleteCategoryItem({
    required int id,
  }) async {
    emit(DeleteCategoryItemLoading());
    var response = await repo.deleteCategorySub(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (categoryDetails?.items != null) {
          categoryDetails!.items!.removeWhere((category) => category.id == id);
        }

        emit(DeleteCategoryItemSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeleteCategoryItemFailure());
        error.showError();
      },
    );
  }
}
