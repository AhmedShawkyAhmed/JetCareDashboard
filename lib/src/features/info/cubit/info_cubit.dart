import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/features/info/data/models/info_model.dart';
import 'package:jetboard/src/features/info/data/repo/info_repo.dart';
import 'package:jetboard/src/features/info/data/requests/info_request.dart';

part 'info_state.dart';

class InfoCubit extends Cubit<InfoState> {
  InfoCubit(this.repo) : super(InfoInitial());
  final InfoRepo repo;

  List<InfoModel>? info;
  List<InfoModel>? types;
  List<InfoModel>? units;
  List<InfoModel>? roles;
  List<InfoModel>? categories;
  List<InfoModel>? itemsTypes;

  Future getInfo({
    String? keyword,
    String? type,
  }) async {
    emit(GetInfoLoading());
    var response = await repo.getInfo(
      keyword: keyword,
      type: type,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        info = response.data;
        emit(GetInfoSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetInfoFailure());
        error.showError();
      },
    );
  }

  Future getTypes() async {
    emit(GetTypesLoading());
    var response = await repo.getTypes();
    response.when(
      success: (NetworkBaseModel response) async {
        types = response.data;
        emit(GetTypesSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetTypesFailure());
        error.showError();
      },
    );
  }

  Future getUnit() async {
    emit(GetUnitLoading());
    var response = await repo.getUnit();
    response.when(
      success: (NetworkBaseModel response) async {
        units = response.data;
        emit(GetUnitSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetUnitFailure());
        error.showError();
      },
    );
  }

  Future getRole() async {
    emit(GetRoleLoading());
    var response = await repo.getRole();
    response.when(
      success: (NetworkBaseModel response) async {
        roles = response.data;
        emit(GetRoleSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetRoleFailure());
        error.showError();
      },
    );
  }

  Future getCategory() async {
    emit(GetCategoryLoading());
    var response = await repo.getCategory();
    response.when(
      success: (NetworkBaseModel response) async {
        categories = response.data;
        emit(GetCategorySuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetCategoryFailure());
        error.showError();
      },
    );
  }

  Future getItemsTypes() async {
    emit(GetItemsTypesLoading());
    var response = await repo.getItemsTypes();
    response.when(
      success: (NetworkBaseModel response) async {
        itemsTypes = response.data;
        emit(GetItemsTypesSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetItemsTypesFailure());
        error.showError();
      },
    );
  }

  Future addInfo({
    required InfoRequest request,
  }) async {
    emit(AddInfoLoading());
    var response = await repo.addInfo(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        getInfo();
        NavigationService.pop();
        emit(AddInfoSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(AddInfoFailure());
        error.showError();
      },
    );
  }

  Future updateInfo({
    required InfoRequest request,
  }) async {
    emit(UpdateInfoLoading());
    var response = await repo.updateInfo(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (info != null) {
          InfoModel currentItem =
              info!.firstWhere((item) => item.id == request.id);
          currentItem.titleAr = request.titleAr;
          currentItem.titleEn = request.titleEn;
          currentItem.contentAr = request.contentAr;
          currentItem.contentEn = request.contentEn;
          currentItem.type = request.type;
        }
        NavigationService.pop();
        emit(UpdateInfoSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(UpdateInfoFailure());
        error.showError();
      },
    );
  }

  Future deleteInfo({
    required int id,
  }) async {
    emit(DeleteInfoLoading());
    var response = await repo.deleteInfo(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (info != null) {
          info!.removeWhere((item) => item.id == id);
        }
        emit(DeleteInfoSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeleteInfoFailure());
        error.showError();
      },
    );
  }
}
