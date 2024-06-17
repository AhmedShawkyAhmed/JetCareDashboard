import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/auth/data/models/tab_access_model.dart';
import 'package:jetboard/src/features/auth/data/models/user_model.dart';
import 'package:jetboard/src/features/auth/data/requests/fcm_request.dart';
import 'package:jetboard/src/features/auth/data/requests/login_request.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class AuthWebService {
  factory AuthWebService(Dio dio, {String baseUrl}) = _AuthWebService;

  @POST(EndPoints.login)
  Future<NetworkBaseModel<UserModel>> login({
    @Body() LoginRequest? request,
  });

  @POST(EndPoints.updateFCM)
  Future<NetworkBaseModel> fcm({
    @Body() FCMRequest? request,
  });

  @GET(EndPoints.profile)
  Future<NetworkBaseModel<UserModel>> profile();

  @GET(EndPoints.tabAccess)
  Future<NetworkBaseModel<TabAccessModel>> getTabAccess({
    @Query("moderator_id") int? id,
  });

  @GET(EndPoints.logout)
  Future<NetworkBaseModel> logout();
}
