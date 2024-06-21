import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/info/data/models/info_model.dart';
import 'package:jetboard/src/features/info/data/requests/info_request.dart';
import 'package:retrofit/retrofit.dart';

part 'info_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class InfoWebService {
  factory InfoWebService(Dio dio, {String baseUrl}) = _InfoWebService;

  @GET(EndPoints.getInfo)
  Future<NetworkBaseModel<List<InfoModel>>> getInfo({
    @Query("keyword") String? keyword,
    @Query("type") String? type,
  });

  @GET(EndPoints.getTypes)
  Future<NetworkBaseModel<List<InfoModel>>> getTypes();

  @GET(EndPoints.getUnit)
  Future<NetworkBaseModel<List<InfoModel>>> getUnit();

  @GET(EndPoints.getRole)
  Future<NetworkBaseModel<List<InfoModel>>> getRole();

  @GET(EndPoints.getCategory)
  Future<NetworkBaseModel<List<InfoModel>>> getCategory();

  @GET(EndPoints.getItemsTypes)
  Future<NetworkBaseModel<List<InfoModel>>> getItemsTypes();

  @POST(EndPoints.addInfo)
  Future<NetworkBaseModel> addInfo({
    @Body() InfoRequest? request,
  });

  @POST(EndPoints.updateInfo)
  Future<NetworkBaseModel> updateInfo({
    @Body() InfoRequest? request,
  });

  @DELETE(EndPoints.deleteInfo)
  Future<NetworkBaseModel> deleteInfo({
    @Query("id") int? id,
  });
}
