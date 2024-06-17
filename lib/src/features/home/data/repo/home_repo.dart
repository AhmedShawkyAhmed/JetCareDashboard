import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/features/home/data/models/home_statistics_model.dart';
import 'package:jetboard/src/features/home/service/home_web_service.dart';

class HomeRepo {
  final HomeWebService webService;

  HomeRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<HomeStatisticsModel>>> getStatistics({
    String? month,
    String? year,
  }) async {
    try {
      var response = await webService.getStatistics(
        month: month,
        year: year,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
