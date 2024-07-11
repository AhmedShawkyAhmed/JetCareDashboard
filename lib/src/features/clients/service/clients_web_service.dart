import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/core/shared/requests/register_request.dart';
import 'package:jetboard/src/features/areas/data/models/area_model.dart';
import 'package:jetboard/src/features/clients/data/models/address_model.dart';
import 'package:jetboard/src/features/clients/data/requests/address_request.dart';
import 'package:retrofit/retrofit.dart';

part 'clients_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class ClientsWebService {
  factory ClientsWebService(Dio dio, {String baseUrl}) = _ClientsWebService;

  @GET(EndPoints.getClients)
  Future<NetworkBaseModel<List<UserModel>>> getClients({
    @Query("keyword") String? keyword,
  });

  @POST(EndPoints.register)
  Future<NetworkBaseModel<UserModel>> addClient({
    @Body() required RegisterRequest request,
  });

  @POST(EndPoints.updateAccount)
  Future<NetworkBaseModel> updateClient({
    @Body() required UserModel request,
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
  Future<NetworkBaseModel> deleteClient({
    @Query("id") required int id,
  });

  @GET(EndPoints.getMyAddresses)
  Future<NetworkBaseModel<List<AddressModel>>> getMyAddresses({
    @Query('user_id') required int userId,
  });

  @POST(EndPoints.addAddress)
  Future<NetworkBaseModel<AddressModel>> addAddress({
    @Body() required AddressRequest request,
  });

  @GET(EndPoints.getStates)
  Future<NetworkBaseModel<List<AreaModel>>> getStates();

  @GET(EndPoints.getAreasOfState)
  Future<NetworkBaseModel<List<AreaModel>>> getAreasOfState({
    @Query('state_id') required int stateId,
  });
}
