import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/features/items/data/models/item_model.dart';
import 'package:jetboard/src/features/items/data/requests/item_request.dart';
import 'package:jetboard/src/features/items/service/items_web_service.dart';

class ItemsRepo {
  final ItemsWebService webService;

  ItemsRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<ItemModel>>>> getItems({
    String? keyword,
  }) async {
    try {
      var response = await webService.getItems(
        keyword: keyword,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<ItemModel>>>> getCorporates({
    String? keyword,
  }) async {
    try {
      var response = await webService.getCorporates(
        keyword: keyword,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<List<ItemModel>>>> getExtras({
    String? keyword,
  }) async {
    try {
      var response = await webService.getExtras(
        keyword: keyword,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> addItem({
    required ItemRequest request,
    required File image,
  }) async {
    try {
      var response = await webService.addItem(
        request: request,
        image: image,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> updateItem({
    required ItemRequest request,
    required File image,
  }) async {
    try {
      var response = await webService.updateItem(
        request: request,
        image: image,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> changeItemStatus({
    required ItemRequest request,
  }) async {
    try {
      var response = await webService.changeItemStatus(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deleteItem({
    required int id,
  }) async {
    try {
      var response = await webService.deleteItem(
        id: id,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
