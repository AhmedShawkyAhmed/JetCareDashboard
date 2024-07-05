import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/features/categories/data/models/category_model.dart';
import 'package:jetboard/src/features/categories/data/requests/category_item_request.dart';
import 'package:jetboard/src/features/categories/data/requests/category_request.dart';
import 'package:jetboard/src/features/categories/service/categories_web_service.dart';

class CategoriesRepo {
  final CategoriesWebService webService;

  CategoriesRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<CategoryModel>>>> getCategories({
    String? keyword,
  }) async {
    try {
      var response = await webService.getCategories(
        keyword: keyword,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<CategoryModel>>> getCategoryDetails({
    required int id,
  }) async {
    try {
      var response = await webService.getCategoryDetails(
        id: id,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<CategoryModel>>> addCategory({
    required CategoryRequest request,
    required File image,
  }) async {
    try {
      var response = await webService.addCategory(
        request: request,
        image: image,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> updateCategory({
    required CategoryRequest request,
    File? image,
  }) async {
    try {
      var response = await webService.updateCategory(
        request: request,
        image: image,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> changeCategoryStatus({
    required CategoryRequest request,
  }) async {
    try {
      var response = await webService.changeCategoryStatus(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deleteCategory({
    required int id,
  }) async {
    try {
      var response = await webService.deleteCategory(
        id: id,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> addCategoryPackage({
    required CategoryItemRequest request,
  }) async {
    try {
      var response = await webService.addCategoryPackage(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> addCategoryItem({
    required CategoryItemRequest request,
  }) async {
    try {
      var response = await webService.addCategoryItem(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deleteCategorySub({
    required int id,
  }) async {
    try {
      var response = await webService.deleteCategorySub(
        id: id,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
