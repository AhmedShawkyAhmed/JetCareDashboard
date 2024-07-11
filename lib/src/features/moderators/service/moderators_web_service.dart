import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/core/shared/requests/register_request.dart';
import 'package:jetboard/src/features/moderators/data/models/moderator_access_model.dart';
import 'package:jetboard/src/features/moderators/data/requests/access_request.dart';
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
    @Query("moderator_id") required int id,
  });

  @POST(EndPoints.register)
  Future<NetworkBaseModel<UserModel>> addModerator({
    @Body() required RegisterRequest request,
  });

  @POST(EndPoints.updateAccount)
  Future<NetworkBaseModel> updateModerator({
    @Body() required UserModel request,
  });

  @POST(EndPoints.createAccess)
  Future<NetworkBaseModel> createAccess({
    @Field("moderator_id") required int moderatorId,
  });

  @POST(EndPoints.updateAccess)
  Future<NetworkBaseModel> updateAccess({
    @Body() required AccessRequest request,
  });

  @POST(EndPoints.activateAccount)
  Future<NetworkBaseModel> activateAccount({
    @Field("user_id") required int userId,
  });

  @POST(EndPoints.stopAccount)
  Future<NetworkBaseModel> stopAccount({
    @Field("user_id") required int userId,
  });

  @POST(EndPoints.userAdminComment)
  Future<NetworkBaseModel> userAdminComment({
    @Field("user_id") required int userId,
    @Field("admin_comment") required String adminComment,
  });

  @DELETE(EndPoints.deleteAccount)
  Future<NetworkBaseModel> deleteModerator({
    @Query("id") required int id,
  });
}
