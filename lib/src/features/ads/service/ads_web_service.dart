import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/ads/data/models/ads_model.dart';
import 'package:jetboard/src/features/ads/data/requests/ads_request.dart';
import 'package:retrofit/retrofit.dart';

part 'ads_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class AdsWebService {
  factory AdsWebService(Dio dio, {String baseUrl}) = _AdsWebService;

  @GET(EndPoints.getAds)
  Future<NetworkBaseModel<List<AdsModel>>> getAds({
    @Query("keyword") String? keyword,
  });

  @POST(EndPoints.addAds)
  @MultiPart()
  Future<NetworkBaseModel<AdsModel>> addAds({
    @Body() AdsRequest? request,
    @Part(name: "image") File? image,
  });

  @POST(EndPoints.updateAds)
  @MultiPart()
  Future<NetworkBaseModel> updateAds({
    @Body() AdsRequest? request,
    @Part(name: "image") File? image,
  });

  @POST(EndPoints.changeAdStatus)
  Future<NetworkBaseModel> changeAdStatus({
    @Body() AdsRequest? request,
  });

  @DELETE(EndPoints.deleteAds)
  Future<NetworkBaseModel> deleteAds({
    @Query("id") int? id,
  });
}
