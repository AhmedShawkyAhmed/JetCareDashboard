import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/packages/data/models/package_details_model.dart';
import 'package:jetboard/src/features/packages/data/models/package_model.dart';
import 'package:jetboard/src/features/packages/data/requests/package_details_request.dart';
import 'package:jetboard/src/features/packages/data/requests/package_request.dart';
import 'package:retrofit/retrofit.dart';

part 'packages_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class PackagesWebService {
  factory PackagesWebService(Dio dio, {String baseUrl}) = _PackagesWebService;

  @GET(EndPoints.getAllPackages)
  Future<NetworkBaseModel<List<PackageModel>>> getAllPackages({
    @Query("keyword") String? keyword,
  });

  @GET(EndPoints.getPackageDetails)
  Future<NetworkBaseModel<PackageDetailsModel>> getPackageDetails({
    @Query("id") int? id,
  });

  @POST(EndPoints.addPackage)
  @MultiPart()
  Future<NetworkBaseModel<PackageModel>> addPackage({
    @Body() PackageRequest? request,
    @Part(name: "image") File? image,
  });

  @POST(EndPoints.updatePackage)
  @MultiPart()
  Future<NetworkBaseModel> updatePackage({
    @Body() PackageRequest? request,
    @Part(name: "image") File? image,
  });

  @POST(EndPoints.changePackageStatus)
  Future<NetworkBaseModel> changePackageStatus({
    @Body() PackageRequest? request,
  });

  @DELETE(EndPoints.deletePackage)
  Future<NetworkBaseModel> deletePackage({
    @Query("id") int? id,
  });

  @POST(EndPoints.addPackageItem)
  Future<NetworkBaseModel> addPackageItem({
    @Body() PackageDetailsRequest? request,
  });

  @DELETE(EndPoints.deletePackageItem)
  Future<NetworkBaseModel> deletePackageItem({
    @Query("id") int? id,
  });
}
