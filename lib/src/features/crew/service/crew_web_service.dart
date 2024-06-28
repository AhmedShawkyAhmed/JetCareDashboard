import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/core/shared/requests/register_request.dart';
import 'package:jetboard/src/features/crew/data/models/crew_area_model.dart';
import 'package:retrofit/retrofit.dart';

part 'crew_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class CrewWebService {
  factory CrewWebService(Dio dio, {String baseUrl}) = _CrewWebService;

  @GET(EndPoints.getCrew)
  Future<NetworkBaseModel<List<UserModel>>> getCrews({
    @Query("keyword") String? keyword,
  });

  @POST(EndPoints.register)
  Future<NetworkBaseModel<UserModel>> addCrew({
    @Body() RegisterRequest? request,
  });

  @POST(EndPoints.updateAccount)
  Future<NetworkBaseModel> updateCrew({
    @Body() UserModel? request,
  });

  @POST(EndPoints.activateAccount)
  Future<NetworkBaseModel> activateAccount({
    @Field("user_id") int? userId,
  });

  @POST(EndPoints.stopAccount)
  Future<NetworkBaseModel> stopAccount({
    @Field("user_id") int? userId,
  });

  @POST(EndPoints.userAdminComment)
  Future<NetworkBaseModel> userAdminComment({
    @Field("user_id") int? userId,
    @Field("admin_comment") String? adminComment,
  });

  @DELETE(EndPoints.deleteAccount)
  Future<NetworkBaseModel> deleteCrew({
    @Query("id") int? id,
  });

  @GET(EndPoints.getCrewAreas)
  Future<NetworkBaseModel<List<CrewAreaModel>>> getCrewAreas({
    @Query("crew_id") int? crewId,
  });

  @GET(EndPoints.addAreaToCrew)
  Future<NetworkBaseModel> addAreaToCrew({
    @Field("crew_id") int? crewId,
    @Field("area_id") int? areaId,
  });

  @DELETE(EndPoints.deleteCrewArea)
  Future<NetworkBaseModel> deleteCrewArea({
    @Query("id") int? id,
  });
}
