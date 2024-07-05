import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/features/packages/data/models/package_details_model.dart';
import 'package:jetboard/src/features/packages/data/models/package_model.dart';
import 'package:jetboard/src/features/packages/data/requests/package_details_request.dart';
import 'package:jetboard/src/features/packages/data/requests/package_request.dart';
import 'package:jetboard/src/features/packages/service/packages_web_service.dart';

class PackagesRepo {
  final PackagesWebService webService;

  PackagesRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<PackageModel>>>> getPackages({
    String? keyword,
  }) async {
    try {
      var response = await webService.getAllPackages(
        keyword: keyword,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<PackageDetailsModel>>> getPackageDetails({
    required int id,
  }) async {
    try {
      var response = await webService.getPackageDetails(
        id: id,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<PackageModel>>> addPackage({
    required PackageRequest request,
    required File image,
  }) async {
    try {
      var response = await webService.addPackage(
        request: request,
        image: image,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> updatePackage({
    required PackageRequest request,
     File? image,
  }) async {
    try {
      var response = await webService.updatePackage(
        request: request,
        image: image,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> changePackageStatus({
    required PackageRequest request,
  }) async {
    try {
      var response = await webService.changePackageStatus(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deletePackage({
    required int id,
  }) async {
    try {
      var response = await webService.deletePackage(
        id: id,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> addPackageItem({
    required PackageDetailsRequest request,
  }) async {
    try {
      var response = await webService.addPackageItem(
        request: request,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deletePackageItem({
    required int id,
  }) async {
    try {
      var response = await webService.deletePackageItem(
        id: id,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
