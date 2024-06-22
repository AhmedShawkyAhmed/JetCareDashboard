import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/features/states/data/models/state_model.dart';
import 'package:jetboard/src/features/states/data/repo/state_repo.dart';
import 'package:jetboard/src/features/states/data/requests/state_request.dart';

part 'states_state.dart';

class StatesCubit extends Cubit<StatesState> {
  StatesCubit(this.repo) : super(StatesInitial());
  final StateRepo repo;

  List<StateModel>? states;

  Future switched(StateModel state) async {
    await changeStateStatus(
      request: StateRequest(
        id: state.id,
        isActive: !state.isActive!,
      ),
    );
    emit(PickedSwitchState());
  }

  Future getAllStates({
    String? keyword,
  }) async {
    emit(GetStatesLoading());
    var response = await repo.getAllStates(keyword: keyword);
    response.when(
      success: (NetworkBaseModel response) async {
        states = response.data;
        emit(GetStatesSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetStatesFailure());
        error.showError();
      },
    );
  }

  Future addState({
    required StateRequest request,
  }) async {
    emit(AddStateLoading());
    var response = await repo.addState(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        getAllStates();
        NavigationService.pop();
        emit(AddStateSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(AddStateFailure());
        error.showError();
      },
    );
  }

  Future updateState({
    required StateRequest request,
  }) async {
    emit(UpdateStateLoading());
    var response = await repo.updateState(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (states != null) {
          StateModel currentItem =
              states!.firstWhere((item) => item.id == request.id);
          currentItem.nameAr = request.nameAr;
          currentItem.nameEn = request.nameEn;
        }
        emit(UpdateStateSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(UpdateStateFailure());
        error.showError();
      },
    );
  }

  Future changeStateStatus({
    required StateRequest request,
  }) async {
    emit(ChangeStateStatusLoading());
    var response = await repo.changeStateStatus(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (states != null) {
          states!.firstWhere((item) => item.id == request.id).isActive =
              request.isActive;
        }
        emit(ChangeStateStatusSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(ChangeStateStatusFailure());
        error.showError();
      },
    );
  }

  Future deleteState({
    required int id,
  }) async {
    emit(DeleteStateLoading());
    var response = await repo.deleteState(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (states != null) {
          states!.removeWhere((item) => item.id == id);
        }
        emit(DeleteStateSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeleteStateFailure());
        error.showError();
      },
    );
  }
}
