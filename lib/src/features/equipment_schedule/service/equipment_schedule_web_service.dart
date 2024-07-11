import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/equipment_schedule/data/models/equipment_schedule_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'equipment_schedule_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class EquipmentScheduleWebService {
  factory EquipmentScheduleWebService(Dio dio, {String baseUrl}) =
      _EquipmentScheduleWebService;

  @GET(EndPoints.getEquipmentSchedule)
  Future<NetworkBaseModel<List<EquipmentScheduleModel>>> getEquipmentSchedule();

  @POST(EndPoints.assignEquipment)
  Future<NetworkBaseModel> assignEquipment({
    @Field("equipment_id") required int equipmentId,
    @Field("crew_id") required int crewId,
    @Field("date") required String date,
  });

  @POST(EndPoints.returnEquipment)
  Future<NetworkBaseModel> returnEquipment({
    @Field("id") required int id,
    @Field("date") required String date,
  });
}
