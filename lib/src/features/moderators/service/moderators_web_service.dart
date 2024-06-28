import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/auth/data/models/user_model.dart';
import 'package:jetboard/src/features/moderators/data/models/moderator_access_model.dart';
import 'package:jetboard/src/features/moderators/data/requests/access_request.dart';
import 'package:jetboard/src/features/moderators/data/requests/register_request.dart';
import 'package:retrofit/retrofit.dart';

part 'moderators_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class ModeratorsWebService {
  factory ModeratorsWebService(Dio dio, {String baseUrl}) =
      _ModeratorsWebService;

  @GET(EndPoints.getModerators)
  Future<NetworkBaseModel<List<UserModel>>> getModerators({
    @Query("keyword") String? keyword,
  });

  @GET(EndPoints.getTabAccess)
  Future<NetworkBaseModel<ModeratorAccessModel>> getTabAccess({
    @Query("moderator_id") int? id,
  });

  @POST(EndPoints.register)
  Future<NetworkBaseModel<UserModel>> register({
    @Body() RegisterRequest? request,
  });

  @POST(EndPoints.updateAccount)
  Future<NetworkBaseModel> updateAccount({
    @Body() UserModel? request,
  });

  @POST(EndPoints.createAccess)
  Future<NetworkBaseModel> createAccess({
    @Field("moderator_id") int? moderatorId,
  });

  @POST(EndPoints.updateAccess)
  Future<NetworkBaseModel> updateAccess({
    @Body() AccessRequest? request,
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
  Future<NetworkBaseModel> deleteAccount({
    @Query("id") int? id,
  });
}
