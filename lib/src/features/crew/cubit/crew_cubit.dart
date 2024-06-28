import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/core/shared/requests/register_request.dart';
import 'package:jetboard/src/core/shared/views/indicator_view.dart';
import 'package:jetboard/src/core/shared/widgets/toast.dart';
import 'package:jetboard/src/features/crew/data/models/crew_area_model.dart';
import 'package:jetboard/src/features/crew/data/repo/crew_repo.dart';

part 'crew_state.dart';

class CrewCubit extends Cubit<CrewState> {
  CrewCubit(this.repo) : super(CrewInitial());
  final CrewRepo repo;

  List<UserModel>? crew;
  List<CrewAreaModel>? crewAreas;
  List<int> areaIds = [];
  List<int> crewAreasIds = [];

  bool pass = true;

  void isPassword() {
    pass = !pass;
  }

  Future switched(UserModel crew) async {
    if (crew.isActive!) {
      await stopAccount(userId: crew.id!);
    } else {
      await activateAccount(userId: crew.id!);
    }
    emit(PickedSwitchState());
  }

  Future getCrew({
    String? keyword,
  }) async {
    emit(GetCrewLoading());
    var response = await repo.getCrews(
      keyword: keyword,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        crew = response.data;
        emit(GetCrewSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetCrewFailure());
        error.showError();
      },
    );
  }

  Future addCrew({
    required RegisterRequest request,
  }) async {
    if (request.name == "") {
      DefaultToast.showMyToast("Please Enter the Full Name");
      return;
    } else if (request.phone == "" || request.phone.length < 11) {
      DefaultToast.showMyToast("Please Enter Correct Phone Number");
      return;
    } else if (request.email == "") {
      DefaultToast.showMyToast("Please Enter Correct Email Address");
      return;
    } else if (request.password == "" || request.password.length < 8) {
      DefaultToast.showMyToast("Please Enter Password more than 8 Characters");
      return;
    }
    IndicatorView.showIndicator();
    emit(AddCrewLoading());
    var response = await repo.addCrew(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(AddCrewSuccess());
        NavigationService.pop();
        NavigationService.pop();
      },
      failure: (NetworkExceptions error) {
        emit(AddCrewFailure());
        NavigationService.pop();
        error.showError();
      },
    );
  }

  Future updateCrew({
    required UserModel request,
  }) async {
    IndicatorView.showIndicator();
    emit(UpdateCrewLoading());
    var response = await repo.updateCrew(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(UpdateCrewSuccess());
        NavigationService.pop();
        NavigationService.pop();
      },
      failure: (NetworkExceptions error) {
        emit(UpdateCrewFailure());
        NavigationService.pop();
        error.showError();
      },
    );
  }

  Future activateAccount({
    required int userId,
  }) async {
    emit(ActivateAccountLoading());
    var response = await repo.activateAccount(
      userId: userId,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (crew != null) {
          crew!.firstWhere((item) => item.id == userId).isActive = true;
        }
        emit(ActivateAccountSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(ActivateAccountFailure());
        error.showError();
      },
    );
  }

  Future stopAccount({
    required int userId,
  }) async {
    emit(StopAccountLoading());
    var response = await repo.stopAccount(
      userId: userId,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (crew != null) {
          crew!.firstWhere((item) => item.id == userId).isActive = false;
        }
        emit(StopAccountSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(StopAccountFailure());
        error.showError();
      },
    );
  }

  Future userAdminComment({
    required int userId,
    required String adminComment,
    required VoidCallback afterSuccess,
  }) async {
    emit(UserAdminCommentLoading());
    var response = await repo.userAdminComment(
      userId: userId,
      adminComment: adminComment,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(UserAdminCommentSuccess());
        afterSuccess();
      },
      failure: (NetworkExceptions error) {
        emit(UserAdminCommentFailure());
        error.showError();
      },
    );
  }

  Future deleteCrew({
    required int id,
  }) async {
    emit(DeleteCrewLoading());
    var response = await repo.deleteCrew(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(DeleteCrewSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeleteCrewFailure());
        error.showError();
      },
    );
  }

  Future getCrewAreas({
    required int crewId,
  }) async {
    areaIds.clear();
    crewAreasIds.clear();
    emit(GetCrewAreaLoading());
    var response = await repo.getCrewAreas(
      crewId: crewId,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        crewAreas = response.data;
        for (int a = 0; a < crewAreas!.length; a++) {
          areaIds.add(crewAreas![a].area!.id!);
          crewAreasIds.add(crewAreas![a].id!);
        }
        emit(GetCrewAreaSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetCrewAreaFailure());
        error.showError();
      },
    );
  }

  Future addAreaToCrew({
    required int crewId,
    required int areaId,
  }) async {
    emit(AddCrewAreaLoading());
    var response = await repo.addAreaToCrew(
      crewId: crewId,
      areaId: areaId,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        getCrewAreas(crewId: crewId);
        emit(AddCrewAreaSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(AddCrewAreaFailure());
        error.showError();
      },
    );
  }

  Future deleteCrewArea({
    required int areaId,
  }) async {
    emit(DeleteCrewAreaLoading());
    var response = await repo.deleteCrewArea(
      id: crewAreasIds[areaIds.indexOf(areaId)],
    );
    response.when(
      success: (NetworkBaseModel response) async {
        crewAreasIds.remove(crewAreasIds[areaIds.indexOf(areaId)]);
        areaIds.remove(areaId);
        emit(DeleteCrewAreaSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeleteCrewAreaFailure());
        error.showError();
      },
    );
  }
}
