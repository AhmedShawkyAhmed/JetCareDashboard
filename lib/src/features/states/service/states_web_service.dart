import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/states/data/models/state_model.dart';
import 'package:jetboard/src/features/states/data/requests/state_request.dart';
import 'package:retrofit/retrofit.dart';

part 'states_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class StatesWebService {
  factory StatesWebService(Dio dio, {String baseUrl}) = _StatesWebService;

  @GET(EndPoints.getAllStates)
  Future<NetworkBaseModel<List<StateModel>>> getAllStates({
    @Query("keyword") String? keyword,
  });

  @POST(EndPoints.addState)
  Future<NetworkBaseModel> addState({
    @Body() required StateRequest request,
  });

  @POST(EndPoints.updateState)
  Future<NetworkBaseModel> updateState({
    @Body() required StateRequest request,
  });

  @POST(EndPoints.changeStateStatus)
  Future<NetworkBaseModel> changeStateStatus({
    @Body() required StateRequest request,
  });

  @DELETE(EndPoints.deleteState)
  Future<NetworkBaseModel> deleteState({
    @Query("id") required int id,
  });
}
