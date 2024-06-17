import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/home/data/models/home_statistics_model.dart';
import 'package:retrofit/retrofit.dart';

part 'home_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class HomeWebService {
  factory HomeWebService(Dio dio, {String baseUrl}) = _HomeWebService;

  @GET(EndPoints.getStatistics)
  Future<NetworkBaseModel<HomeStatisticsModel>> getStatistics({
    @Query("month") String? month,
    @Query("year") String? year,
  });
}
