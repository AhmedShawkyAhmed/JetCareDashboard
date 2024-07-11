import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/core/shared/requests/register_request.dart';
import 'package:jetboard/src/core/shared/views/indicator_view.dart';
import 'package:jetboard/src/core/shared/widgets/toast.dart';
import 'package:jetboard/src/features/moderators/data/models/moderator_access_model.dart';
import 'package:jetboard/src/features/moderators/data/repo/moderators_repo.dart';
import 'package:jetboard/src/features/moderators/data/requests/access_request.dart';

part 'moderators_state.dart';

class ModeratorsCubit extends Cubit<ModeratorsState> {
  ModeratorsCubit(this.repo) : super(ModeratorsInitial());

  final ModeratorsRepo repo;

  List<UserModel>? moderators;
  ModeratorAccessModel? accessModel;

  bool pass = true;

  void isPassword() {
    pass = !pass;
  }

  Future switched(UserModel moderator) async {
    if (moderator.isActive!) {
      await stopAccount(userId: moderator.id!);
    } else {
      await activateAccount(userId: moderator.id!);
    }
    emit(PickedSwitchState());
  }

  Future getModerators({
    String? keyword,
  }) async {
    emit(GetModeratorsLoading());
    var response = await repo.getModerators(
      keyword: keyword,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        moderators = response.data;
        emit(GetModeratorsSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetModeratorsFailure());
        error.showError();
      },
    );
  }

  Future getTabAccess({
    required int id,
  }) async {
    emit(GetTabAccessLoading());
    var response = await repo.getTabAccess(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        accessModel = response.data;
        emit(GetTabAccessSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetTabAccessFailure());
        error.showError();
      },
    );
  }

  Future addModerator({
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
    emit(AddModeratorLoading());
    var response = await repo.addModerator(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(AddModeratorSuccess());
        await createAccess(moderatorId: response.data.id);
        NavigationService.pop();
        NavigationService.pop();
      },
      failure: (NetworkExceptions error) {
        emit(AddModeratorFailure());
        NavigationService.pop();
        error.showError();
      },
    );
  }

  Future updateModerator({
    required UserModel request,
  }) async {
    IndicatorView.showIndicator();
    emit(UpdateModeratorLoading());
    var response = await repo.updateModerator(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(UpdateModeratorSuccess());
        NavigationService.pop();
        NavigationService.pop();
      },
      failure: (NetworkExceptions error) {
        emit(UpdateModeratorFailure());
        NavigationService.pop();
        error.showError();
      },
    );
  }

  Future createAccess({
    required int moderatorId,
  }) async {
    emit(CreateAccessLoading());
    var response = await repo.createAccess(
      moderatorId: moderatorId,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(CreateAccessSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(CreateAccessFailure());
        error.showError();
      },
    );
  }

  Future updateAccess({
    required AccessRequest request,
    required VoidCallback afterSuccess,
  }) async {
    emit(UpdateAccessLoading());
    var response = await repo.updateAccess(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        afterSuccess();
        emit(UpdateAccessSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(UpdateAccessFailure());
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
        if (moderators != null) {
          moderators!.firstWhere((item) => item.id == userId).isActive =
          true;
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
        if (moderators != null) {
          moderators!.firstWhere((item) => item.id == userId).isActive =
              false;
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

  Future deleteModerator({
    required int id,
  }) async {
    emit(DeleteModeratorLoading());
    var response = await repo.deleteModerator(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(DeleteModeratorSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeleteModeratorFailure());
        error.showError();
      },
    );
  }
}
