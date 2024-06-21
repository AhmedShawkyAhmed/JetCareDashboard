import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/areas/data/models/area_model.dart';
import 'package:jetboard/src/features/areas/data/models/state_model.dart';
import 'package:jetboard/src/features/areas/data/requests/area_request.dart';
import 'package:retrofit/retrofit.dart';

part 'areas_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class AreasWebService {
  factory AreasWebService(Dio dio, {String baseUrl}) = _AreasWebService;

  @GET(EndPoints.getAllStates)
  Future<NetworkBaseModel<List<StateModel>>> getAllStates();

  @GET(EndPoints.getAllAreas)
  Future<NetworkBaseModel<List<AreaModel>>> getAllAreas({
    @Query("keyword") String? keyword,
  });

  @GET(EndPoints.getAreasOfState)
  Future<NetworkBaseModel<List<AreaModel>>> getAreasOfState({
    @Query("state_id") int? stateId,
  });

  @POST(EndPoints.addArea)
  Future<NetworkBaseModel> addArea({
    @Body() AreaRequest? request,
  });

  @POST(EndPoints.updateArea)
  Future<NetworkBaseModel> updateArea({
    @Body() AreaRequest? request,
  });

  @POST(EndPoints.changeAreaStatus)
  Future<NetworkBaseModel> changeAreaStatus({
    @Body() AreaRequest? request,
  });

  @DELETE(EndPoints.deleteArea)
  Future<NetworkBaseModel> deleteArea({
    @Query("id") int? id,
  });
}
