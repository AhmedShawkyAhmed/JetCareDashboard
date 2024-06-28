import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/features/equipments/data/models/equipment_model.dart';
import 'package:jetboard/src/features/equipments/data/repo/equipment_repo.dart';

part 'equipment_state.dart';

class EquipmentCubit extends Cubit<EquipmentState> {
  EquipmentCubit(this.repo) : super(EquipmentInitial());
  final EquipmentRepo repo;

  List<EquipmentModel>? equipments;

  Future getEquipment({
    String? keyword,
  }) async {
    emit(GetEquipmentLoading());
    var response = await repo.getEquipment(
      keyword: keyword,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        equipments = response.data;
        emit(GetEquipmentSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetEquipmentFailure());
        error.showError();
      },
    );
  }

  Future addEquipment({
    required String code,
    required String name,
  }) async {
    emit(AddEquipmentLoading());
    var response = await repo.addEquipment(
      code: code,
      name: name,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (equipments != null) {
          equipments!.add(response.data);
        }
        NavigationService.pop();
        emit(AddEquipmentSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(AddEquipmentFailure());
        error.showError();
      },
    );
  }

  Future deleteEquipment({
    required int id,
  }) async {
    emit(DeleteEquipmentLoading());
    var response = await repo.deleteEquipment(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (equipments != null) {
          equipments!.removeWhere((item) => item.id == id);
        }
        emit(DeleteEquipmentSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeleteEquipmentFailure());
        error.showError();
      },
    );
  }
}
