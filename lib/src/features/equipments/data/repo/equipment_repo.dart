import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/network/models/network_result.dart';
import 'package:jetboard/src/features/equipments/data/models/equipment_model.dart';
import 'package:jetboard/src/features/equipments/service/equipment_web_service.dart';

class EquipmentRepo{
  final EquipmentWebService webService;

  EquipmentRepo(this.webService);



  Future<NetworkResult<NetworkBaseModel<List<EquipmentModel>>>> getEquipment({
    String? keyword,
  }) async {
    try {
      var response = await webService.getEquipment(keyword: keyword);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel<EquipmentModel>>> addEquipment({
    required String code,
    required String name,
  }) async {
    try {
      var response = await webService.addEquipment(code: code, name: name);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }

  Future<NetworkResult<NetworkBaseModel>> deleteEquipment({
    required int id,
  }) async {
    try {
      var response = await webService.deleteEquipment(id: id);
      return NetworkResult.success(response);
    } on DioException catch (error) {
      return NetworkResult.failure(NetworkExceptions.getException(error));
    }
  }
}