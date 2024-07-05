import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/categories/data/models/category_model.dart';
import 'package:jetboard/src/features/categories/data/requests/category_item_request.dart';
import 'package:jetboard/src/features/categories/data/requests/category_request.dart';
import 'package:retrofit/retrofit.dart';

part 'categories_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class CategoriesWebService {
  factory CategoriesWebService(Dio dio, {String baseUrl}) =
      _CategoriesWebService;

  @GET(EndPoints.getCategories)
  Future<NetworkBaseModel<List<CategoryModel>>> getCategories({
    @Query("keyword") String? keyword,
  });

  @GET(EndPoints.getCategoryDetails)
  Future<NetworkBaseModel<CategoryModel>> getCategoryDetails({
    @Query("id") int? id,
  });

  @POST(EndPoints.addCategory)
  @MultiPart()
  Future<NetworkBaseModel<CategoryModel>> addCategory({
    @Body() CategoryRequest? request,
    @Part(name: "image") File? image,
  });

  @POST(EndPoints.updateCategory)
  @MultiPart()
  Future<NetworkBaseModel> updateCategory({
    @Body() CategoryRequest? request,
    @Part(name: "image") File? image,
  });

  @POST(EndPoints.changeCategoryStatus)
  Future<NetworkBaseModel> changeCategoryStatus({
    @Body() CategoryRequest? request,
  });

  @DELETE(EndPoints.deleteCategory)
  Future<NetworkBaseModel> deleteCategory({
    @Query("id") int? id,
  });

  @POST(EndPoints.addCategoryPackage)
  Future<NetworkBaseModel> addCategoryPackage({
    @Body() CategoryItemRequest? request,
  });

  @POST(EndPoints.addCategoryItem)
  Future<NetworkBaseModel> addCategoryItem({
    @Body() CategoryItemRequest? request,
  });

  @DELETE(EndPoints.deleteCategorySub)
  Future<NetworkBaseModel> deleteCategorySub({
    @Query("id") int? id,
  });
}
