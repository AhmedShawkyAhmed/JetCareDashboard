import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/equipments/data/models/equipment_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'equipment_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class EquipmentWebService {
  factory EquipmentWebService(Dio dio, {String baseUrl}) = _EquipmentWebService;

  @GET(EndPoints.getEquipment)
  Future<NetworkBaseModel<List<EquipmentModel>>> getEquipment({
    @Query("keyword") String? keyword,
  });

  @POST(EndPoints.addEquipment)
  Future<NetworkBaseModel<EquipmentModel>> addEquipment({
    @Field("code") required String code,
    @Field("name") required String name,
  });

  @DELETE(EndPoints.deleteEquipment)
  Future<NetworkBaseModel> deleteEquipment({
    @Query("id") required int id,
  });
}
