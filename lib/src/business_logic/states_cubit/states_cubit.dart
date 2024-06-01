import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/network_service.dart';
import 'package:jetboard/src/data/network/requests/area_request.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';
import 'package:jetboard/src/data/network/responses/states_response.dart';
part 'states_state.dart';

class StatesCubit extends Cubit<StatesState> {
  StatesCubit(this.networkService) : super(StatesInitial());
  NetworkService networkService;
  static StatesCubit get(context) => BlocProvider.of(context);

  List<String> statesList = [];
  StatesResponse? allStatesResponse;
  GlobalResponse? addStateResponse,updateStateResponse,deleteStateResponse,changeStateResponse;

  void switched(int index) {
    allStatesResponse!.statesList![index].active == 1
        ? allStatesResponse!.statesList![index].active = 0
        : allStatesResponse!.statesList![index].active = 1;
    emit(PickedSwitchState());
  }

  Future getAllStates({String? keyword}) async {
    try {
      emit(GetStatesLoading());
      await networkService.get(
        url: EndPoints.getAllStates,
        query: {
          "keyword" : keyword,
        },
      ).then((value) {
        printSuccess(value.data.toString());
        allStatesResponse = StatesResponse.fromJson(value.data);
        for(int i = 0; i< allStatesResponse!.statesList!.length; i++){
          statesList.add(allStatesResponse!.statesList![i].nameAr!);
        }
        emit(GetStatesSuccess());
      });
    } on DioError catch (n) {
      emit(GetStatesError());
      printError(n.toString());
    } catch (e) {
      emit(GetStatesError());
      printError(e.toString());
    }
  }

  Future addState({
    required AreaRequest areaRequest,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(AddStatesLoading());
      await networkService.post(
        url: EndPoints.addState,
        body: {
          'nameEn': areaRequest.nameEn,
          'nameAr': areaRequest.nameAr,
        },
      ).then((value) {
        printSuccess(value.toString());
        addStateResponse = GlobalResponse.fromJson(value.data);
        emit(AddStatesSuccess());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(AddStatesError());
      printError(n.toString());
    } catch (e) {
      emit(AddStatesError());
      printError(e.toString());
    }
  }

  Future updateState({
    required AreaRequest areaRequest,
  }) async {
    try {
      emit(UpdateStatesLoading());
      await networkService.post(
        url: EndPoints.addState,
        body: {
          'id': areaRequest.id,
          'nameEn': areaRequest.nameEn,
          'nameAr': areaRequest.nameAr,
        },
      ).then((value) {
        printSuccess(value.toString());
        updateStateResponse = GlobalResponse.fromJson(value.data);
        emit(UpdateStatesSuccess());
      });
    } on DioError catch (n) {
      emit(UpdateStatesError());
      printError(n.toString());
    } catch (e) {
      emit(UpdateStatesError());
      printError(e.toString());
    }
  }

  Future deleteState({
    required int id,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(DeleteStatesLoading());
      await networkService.post(
        url: EndPoints.deleteState,
        body: {
          'id': id,
        },
      ).then((value) {
        printSuccess(value.toString());
        deleteStateResponse = GlobalResponse.fromJson(value.data);
        emit(DeleteStatesSuccess());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(DeleteStatesError());
      printError(n.toString());
    } catch (e) {
      emit(DeleteStatesError());
      printError(e.toString());
    }
  }

  Future changeStateStatus({
    required int id,
    required int active,
  }) async {
    try {
      emit(ChangeStatesLoading());
      await networkService.post(
        url: EndPoints.changeStateStatus,
        body: {
          'id': id,
          'active': active,
        },
      ).then((value) {
        printSuccess(value.toString());
        changeStateResponse = GlobalResponse.fromJson(value.data);
        emit(ChangeStatesSuccess());
      });
    } on DioError catch (n) {
      emit(ChangeStatesError());
      printError(n.toString());
    } catch (e) {
      emit(ChangeStatesError());
      printError(e.toString());
    }
  }
}
