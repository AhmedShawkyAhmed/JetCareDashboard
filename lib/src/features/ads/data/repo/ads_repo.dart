import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/features/ads/data/models/ads_model.dart';
import 'package:jetboard/src/features/ads/data/requests/ads_request.dart';
import 'package:jetboard/src/features/ads/service/ads_web_service.dart';

class AdsRepo {
  final AdsWebService webService;

  AdsRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<AdsModel>>>> getAds({
    String? keyword,
  }) async {
    try {
      var response = await webService.getAds(keyword: keyword);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> addAds({
    required AdsRequest request,
    required File image,
  }) async {
    try {
      var response = await webService.addAds(request: request, image: image);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> updateAds({
    required AdsRequest request,
    File? image,
  }) async {
    try {
      var response = await webService.updateAds(request: request,image: image);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> changeAdStatus({
    required AdsRequest request,
  }) async {
    try {
      var response = await webService.changeAdStatus(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deleteAds({
    required int id,
  }) async {
    try {
      var response = await webService.deleteAds(id: id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
