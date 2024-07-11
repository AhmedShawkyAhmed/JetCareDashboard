import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/items/data/models/item_model.dart';
import 'package:jetboard/src/features/items/data/requests/item_request.dart';
import 'package:retrofit/retrofit.dart';

part 'items_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class ItemsWebService {
  factory ItemsWebService(Dio dio, {String baseUrl}) = _ItemsWebService;

  @GET(EndPoints.getItems)
  Future<NetworkBaseModel<List<ItemModel>>> getItems({
    @Query("keyword") String? keyword,
  });

  @GET(EndPoints.getCorporates)
  Future<NetworkBaseModel<List<ItemModel>>> getCorporates({
    @Query("keyword") String? keyword,
  });

  @GET(EndPoints.getExtras)
  Future<NetworkBaseModel<List<ItemModel>>> getExtras({
    @Query("keyword") String? keyword,
  });

  @POST(EndPoints.addItem)
  @MultiPart()
  Future<NetworkBaseModel> addItem({
    @Body() required ItemRequest request,
    @Part(name: "image") required File image,
  });

  @POST(EndPoints.updateItem)
  @MultiPart()
  Future<NetworkBaseModel> updateItem({
    @Body() ItemRequest? request,
    @Part(name: "image") File? image,
  });

  @POST(EndPoints.changeItemStatus)
  Future<NetworkBaseModel> changeItemStatus({
    @Body() required ItemRequest request,
  });

  @DELETE(EndPoints.deleteItem)
  Future<NetworkBaseModel> deleteItem({
    @Query("id") required int id,
  });
}
