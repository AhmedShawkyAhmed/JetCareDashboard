import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/features/periods/data/models/period_model.dart';
import 'package:jetboard/src/features/periods/data/repo/period_repo.dart';
import 'package:jetboard/src/features/periods/data/requests/period_request.dart';

part 'period_state.dart';

class PeriodCubit extends Cubit<PeriodState> {
  PeriodCubit(this.repo) : super(PeriodInitial());
  final PeriodRepo repo;

  List<PeriodModel>? periods;

  Future switched(PeriodModel period)async {
    await changePeriodStatus(
      request: PeriodRequest(
        id: period.id,
        isActive: !period.isActive!,
      ),
    );
    emit(PickedSwitchState());
  }

  Future getPeriods({
    String? keyword,
  }) async {
    emit(GetPeriodLoading());
    var response = await repo.getPeriods(
      keyword: keyword,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        periods = response.data;
        emit(GetPeriodSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetPeriodFailure());
        error.showError();
      },
    );
  }

  Future addPeriod({
    required PeriodRequest request,
  }) async {
    emit(AddPeriodLoading());
    var response = await repo.addPeriod(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        getPeriods();
        emit(AddPeriodSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(AddPeriodFailure());
        error.showError();
      },
    );
  }

  Future updatePeriod({
    required PeriodRequest request,
  }) async {
    emit(UpdatePeriodLoading());
    var response = await repo.updatePeriod(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (periods != null) {
          periods!.firstWhere((item) => item.id == request.id).from =
              request.from;
          periods!.firstWhere((item) => item.id == request.id).to = request.to;
        }
        emit(UpdatePeriodSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(UpdatePeriodFailure());
        error.showError();
      },
    );
  }

  Future changePeriodStatus({
    required PeriodRequest request,
  }) async {
    emit(UpdatePeriodLoading());
    var response = await repo.changePeriodStatus(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (periods != null) {
          periods!.firstWhere((item) => item.id == request.id).isActive =
              request.isActive;
        }
        emit(UpdatePeriodSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(UpdatePeriodFailure());
        error.showError();
      },
    );
  }

  Future deletePeriod({
    required int id,
  }) async {
    emit(DeletePeriodLoading());
    var response = await repo.deletePeriod(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (periods != null) {
          periods!.removeWhere((item) => item.id == id);
        }
        emit(DeletePeriodSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeletePeriodFailure());
        error.showError();
      },
    );
  }
}
