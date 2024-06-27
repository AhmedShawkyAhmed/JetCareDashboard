import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/calendar/data/models/calendar_model.dart';
import 'package:jetboard/src/features/calendar/data/requests/calendar_request.dart';
import 'package:retrofit/retrofit.dart';

part 'calendar_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class CalendarWebService {
  factory CalendarWebService(Dio dio, {String baseUrl}) = _CalendarWebService;

  @GET(EndPoints.getCalendar)
  Future<NetworkBaseModel<List<CalendarModel>>> getCalendar({
    @Query("month") int? month,
    @Query("year") int? year,
  });

  @POST(EndPoints.addCalendarPeriod)
  Future<NetworkBaseModel> addCalendarPeriod({
    @Body() CalendarRequest? request,
  });

  @DELETE(EndPoints.deleteCalendarPeriod)
  Future<NetworkBaseModel> deleteCalendarPeriod({
    @Query("id") int? id,
  });
}
