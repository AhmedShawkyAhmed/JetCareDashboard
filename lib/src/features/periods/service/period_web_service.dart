import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/periods/data/models/period_model.dart';
import 'package:jetboard/src/features/periods/data/requests/period_request.dart';
import 'package:retrofit/retrofit.dart';

part 'period_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class PeriodWebService {
  factory PeriodWebService(Dio dio, {String baseUrl}) = _PeriodWebService;

  @GET(EndPoints.tabAccess)
  Future<NetworkBaseModel<List<PeriodModel>>> getPeriods({
    @Query("keyword") String? keyword,
  });

  @POST(EndPoints.addPeriod)
  Future<NetworkBaseModel> addPeriod({
    @Body() PeriodRequest? request,
  });

  @POST(EndPoints.updatePeriod)
  Future<NetworkBaseModel> updatePeriod({
    @Body() PeriodRequest? request,
  });

  @POST(EndPoints.changePeriodStatus)
  Future<NetworkBaseModel> changePeriodStatus({
    @Body() PeriodRequest? request,
  });

  @DELETE(EndPoints.deletePeriod)
  Future<NetworkBaseModel> deletePeriod({
    @Query("id") int? id,
  });
}
