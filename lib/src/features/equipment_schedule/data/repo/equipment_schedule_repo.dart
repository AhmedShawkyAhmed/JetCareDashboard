import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/features/equipment_schedule/data/models/equipment_schedule_model.dart';
import 'package:jetboard/src/features/equipment_schedule/service/equipment_schedule_web_service.dart';

class EquipmentScheduleRepo {
  final EquipmentScheduleWebService webService;

  EquipmentScheduleRepo(this.webService);

  Future<NetworkResult<NetworkBaseModel<List<EquipmentScheduleModel>>>>
      getEquipmentSchedule() async {
    try {
      var response = await webService.getEquipmentSchedule();
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> assignEquipment({
    required int equipmentId,
    required int crewId,
    required String date,
  }) async {
    try {
      var response = await webService.assignEquipment(
        equipmentId: equipmentId,
        crewId: crewId,
        date: date,
      );
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> returnEquipment({
    required int id,
    required String date,
  }) async {
    try {
      var response = await webService.returnEquipment(id: id, date: date);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}
