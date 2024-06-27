import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/features/calendar/data/models/calendar_model.dart';
import 'package:jetboard/src/features/calendar/data/requests/calendar_request.dart';
import 'package:jetboard/src/features/calendar/service/calendar_web_service.dart';

class CalendarRepo {
  final CalendarWebService webService;

  CalendarRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<CalendarModel>>>> getCalendar({
    required int month,
    required int year,
  }) async {
    try {
      var response = await webService.getCalendar(month: month, year: year);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> addCalendarPeriod({
    required CalendarRequest request,
  }) async {
    try {
      var response = await webService.addCalendarPeriod(request: request);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deleteCalendarPeriod({
    required int id,
  }) async {
    try {
      var response = await webService.deleteCalendarPeriod(id: id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
