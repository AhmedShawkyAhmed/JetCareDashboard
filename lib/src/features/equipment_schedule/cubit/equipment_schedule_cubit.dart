import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/toast.dart';
import 'package:jetboard/src/features/equipment_schedule/data/models/equipment_schedule_model.dart';
import 'package:jetboard/src/features/equipment_schedule/data/repo/equipment_schedule_repo.dart';

part 'equipment_schedule_state.dart';

class EquipmentScheduleCubit extends Cubit<EquipmentScheduleState> {
  EquipmentScheduleCubit(this.repo) : super(EquipmentScheduleInitial());
  final EquipmentScheduleRepo repo;

  List<EquipmentScheduleModel>? schedules;

  Future getEquipmentSchedule() async {
    emit(GetEquipmentScheduleLoading());
    var response = await repo.getEquipmentSchedule();
    response.when(
      success: (NetworkBaseModel response) async {
        schedules = response.data;
        emit(GetEquipmentScheduleSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetEquipmentScheduleFailure());
        error.showError();
      },
    );
  }

  Future assignEquipment({
    required int equipmentId,
    required int crewId,
    required String date,
    required String time,
  }) async {
    if (equipmentId == 0) {
      DefaultToast.showMyToast("Select Equipment");
      return;
    }
    if (crewId == 0) {
      DefaultToast.showMyToast("Select Crew");
      return;
    }
    if (date == "") {
      DefaultToast.showMyToast("Select Date");
      return;
    }
    if (time == "") {
      DefaultToast.showMyToast("Select Time");
      return;
    }
    emit(AssignEquipmentLoading());
    var response = await repo.assignEquipment(
      equipmentId: equipmentId,
      crewId: crewId,
      date: "$date - $time",
    );
    response.when(
      success: (NetworkBaseModel response) async {
        getEquipmentSchedule();
        NavigationService.pop();
        emit(AssignEquipmentSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(AssignEquipmentFailure());
        error.showError();
      },
    );
  }

  Future returnEquipment({
    required int id,
    required String date,
    required String time,
  }) async {
    if (date == "") {
      DefaultToast.showMyToast("Select Date");
      return;
    }
    if (time == "") {
      DefaultToast.showMyToast("Select Time");
      return;
    }
    emit(ReturnEquipmentLoading());
    var response = await repo.returnEquipment(
      id: id,
      date: "$date - $time",
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (schedules != null) {
          schedules!.firstWhere((item) => item.id == id).returned = date;
        }
        NavigationService.pop();
        emit(ReturnEquipmentSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(ReturnEquipmentFailure());
        error.showError();
      },
    );
  }
}
