import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/toast.dart';
import 'package:jetboard/src/features/areas/data/models/area_model.dart';
import 'package:jetboard/src/features/areas/data/models/state_model.dart';
import 'package:jetboard/src/features/areas/data/repo/area_repo.dart';
import 'package:jetboard/src/features/areas/data/requests/area_request.dart';

part 'areas_state.dart';

class AreasCubit extends Cubit<AreasState> {
  AreasCubit(this.repo) : super(AreasInitial());
  final AreaRepo repo;

  List<AreaModel>? areas;
  List<AreaModel>? areasOfStates;
  List<StateModel>? states;

  Future switched(AreaModel area) async {
    await changeAreaStatus(
      request: AreaRequest(
        id: area.id,
        isActive: !area.isActive!,
      ),
    );
    emit(PickedSwitchState());
  }

  Future getAllStates() async {
    emit(GetStatesLoading());
    var response = await repo.getAllStates();
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

  Future getAllAreas({
    String? keyword,
  }) async {
    emit(GetAreasLoading());
    var response = await repo.getAllAreas(
      keyword: keyword,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        areas = response.data;
        emit(GetAreasSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetAreasFailure());
        error.showError();
      },
    );
  }

  Future getAreasOfState({
    required int stateId,
  }) async {
    emit(GetAreasOfStateLoading());
    var response = await repo.getAreasOfState(
      stateId: stateId,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        areasOfStates = response.data;
        emit(GetAreasOfStateSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetAreasOfStateFailure());
        error.showError();
      },
    );
  }

  Future addArea({
    required AreaRequest request,
  }) async {
    if (request.price == null &&
        request.discount == null &&
        request.transportation == null) {
      DefaultToast.showMyToast("برجاء إدخال البيانات الناقصة");
      return;
    }
    emit(AddAreaLoading());
    var response = await repo.addArea(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        getAllAreas();
        NavigationService.pop();
        emit(AddAreaSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(AddAreaFailure());
        error.showError();
      },
    );
  }

  Future updateArea({
    required AreaRequest request,
  }) async {
    emit(UpdateAreaLoading());
    var response = await repo.updateArea(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (areas != null) {
          AreaModel currentItem =
              areas!.firstWhere((item) => item.id == request.id);
          currentItem.nameAr = request.nameAr;
          currentItem.nameEn = request.nameEn;
          currentItem.price = request.price;
          currentItem.discount = request.discount;
          currentItem.transportation = request.transportation;
          currentItem.stateId = request.stateId;
        }
        emit(UpdateAreaSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(UpdateAreaFailure());
        error.showError();
      },
    );
  }

  Future changeAreaStatus({
    required AreaRequest request,
  }) async {
    emit(ChangeAreaStatusLoading());
    var response = await repo.changeAreaStatus(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (areas != null) {
          areas!.firstWhere((item) => item.id == request.id).isActive =
              request.isActive;
        }
        emit(ChangeAreaStatusSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(ChangeAreaStatusFailure());
        error.showError();
      },
    );
  }

  Future deleteArea({
    required int id,
  }) async {
    emit(DeleteAreaLoading());
    var response = await repo.deleteArea(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (areas != null) {
          areas!.removeWhere((item) => item.id == id);
        }
        emit(DeleteAreaSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeleteAreaFailure());
        error.showError();
      },
    );
  }
}
