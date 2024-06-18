import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/network_service.dart';
import 'package:jetboard/src/data/models/settings_model.dart';
import 'package:jetboard/src/data/models/user_model.dart';
import 'package:jetboard/src/data/network/requests/user_request.dart';
import 'package:jetboard/src/data/network/responses/access_response.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';
import 'package:jetboard/src/data/network/responses/user_response.dart';
import 'package:jetboard/src/core/shared/widgets/toast.dart';

import '../../core/constants/constants_variables.dart';

part 'moderator_state.dart';

class ModeratorCubit extends Cubit<ModeratorState> {
  ModeratorCubit(this.networkService) : super(ModeratorInitial());
  NetworkService networkService;
  static ModeratorCubit get(context) => BlocProvider.of(context);

  GlobalResponse? globalResponse;
  UserResponse? getModeratorResponse,
      addModeratorResponse,
      deleteModeratorResponse,
      updateModeratorResponse,
      updateModeratorStatusResponse;
  AccessResponse? accessResponse;
  List<String> roleList = [];
  List<UserModel> moderatorList = [];
  List<SettingsModel> settings = [];
  int listCount = 0;
  int index = 0;
  bool pass = true;

  void isPassword() {
    pass = !pass;
    emit(ChangePasswordState());
  }

  void switched(int index) {
    moderatorList[index].active == 1
        ? moderatorList[index].active = 0
        : moderatorList[index].active = 1;
    printSuccess(index.toString());
    emit(ModeratorSwitchState());
  }

  Future getModerator({String? keyword}) async {
    getModeratorResponse = null;
    moderatorList.clear();
    listCount = 0;
    try {
      emit(ModeratorLoadingState());
      await networkService.get(
        url: EndPoints.getAccounts,
        query: {
          "type": "moderator",
          "keyword": keyword,
        },
      ).then((value) {
        emit(ModeratorSuccessState());
        getModeratorResponse = UserResponse.fromJson(value.data);
        moderatorList.addAll(getModeratorResponse!.userModel!);
        listCount = getModeratorResponse!.userModel!.length;
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(ModeratorErrorState());
      printError(n.toString());
    } catch (e) {
      emit(ModeratorErrorState());
      printError(e.toString());
    }
  }

  Future addModerator({
    required UserRequset userRequest,
    required VoidCallback afterSuccess,
    required VoidCallback onError,
  }) async {
    try {
      emit(AddModeratorLoadingState());
      await networkService.post(
        url: EndPoints.register,
        body: {
          'name': userRequest.name,
          'phone': userRequest.phone,
          'email': userRequest.email ?? "empty",
          'password': userRequest.password,
          'role': "moderator",
        },
      ).then((value) {
        DefaultToast.showMyToast(value.data['message']);
        if (value.data['status'] == 200) {
          afterSuccess();
        } else {
          onError();
        }
        addModeratorResponse = UserResponse.fromJson(value.data);
        moderatorList.insert(0, addModeratorResponse!.userModell!);
        listCount += 1;
        createAccess(id: addModeratorResponse!.userModell!.id);
        emit(AddModeratorSuccessState());
      });
    } on DioError catch (n) {
      emit(AddModeratorErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddModeratorErrorState());
      printError(e.toString());
    }
  }

  Future updateCrew({
    required UserRequset userRequest,
    required int index,
    required VoidCallback afterSuccess,
    required VoidCallback onError,
  }) async {
    try {
      emit(UpdateModeratorLoadingState());
      await networkService.post(
        url: EndPoints.updateAccount,
        body: {
          'id': userRequest.id,
          'name': userRequest.name,
          'phone': userRequest.phone,
          'email': userRequest.email,
          'role': "moderator",
        },
      ).then((value) {
        DefaultToast.showMyToast(value.data['message']);
        if(value.data['status'] == 200){
          printSuccess(value.toString());
          final myData = Map<String, dynamic>.from(value.data);
          updateModeratorResponse = UserResponse.fromJson(myData);
          moderatorList[index] = updateModeratorResponse!.userModell!;
          emit(UpdateModeratorSuccessState());
          afterSuccess();
        }else{
          onError();
          emit(UpdateModeratorErrorState());
        }
      });
    } on DioError catch (n) {
      emit(UpdateModeratorErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UpdateModeratorErrorState());
      printError(e.toString());
    }
  }

  Future deleteModerator({required UserModel userModel}) async {
    try {
      emit(DeleteModeratorLoadingState());
      await networkService.post(
        url: EndPoints.deleteAccount,
        body: {
          'id': userModel.id,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        deleteModeratorResponse = UserResponse.fromJson(myData);
        moderatorList.remove(userModel);
        listCount -= 1;
        emit(DeleteModeratorSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(DeleteModeratorErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(DeleteModeratorErrorState());
      printResponse(e.toString());
    }
  }

  Future updateModeratorStatus({
    required UserRequset userRequest,
    required int index,
  }) async {
    try {
      emit(ChangeModeratorLoadingState());
      await networkService.post(
        url: EndPoints.changeAccountStatus,
        body: {
          'id': userRequest.id,
          'active': userRequest.active,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        updateModeratorStatusResponse = UserResponse.fromJson(myData);
        moderatorList[index].active = userRequest.active!;
        emit(ChangeModeratorSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(ChangeModeratorErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(ChangeModeratorErrorState());
      printResponse(e.toString());
    }
  }

  Future createAccess({required int id}) async {
    try {
      emit(CreateAccessLoadingState());
      await networkService.post(
        url: EndPoints.createAccess,
        body: {
          "moderatorId": id,
        },
      ).then((value) {
        DefaultToast.showMyToast(value.data['message']);
        emit(CreateAccessSuccessState());
      });
    } on DioError catch (n) {
      emit(CreateAccessErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(CreateAccessErrorState());
      printResponse(e.toString());
    }
  }

  Future updateAccess({
    required String key,
    required int value,
    required int id,
    required VoidCallback afterSuccess,
  }) async {
    try {
      //emit(UpdateAccessLoadingState());
      await networkService.post(
        url: EndPoints.updateAccess,
        body: {
          "id": id,
          'key': key,
          'value': value,
        },
      ).then((value) {
        DefaultToast.showMyToast(value.data['message']);
        //emit(UpdateAccessSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      //emit(UpdateAccessErrorState());
      printResponse(n.toString());
    } catch (e) {
      //emit(UpdateAccessErrorState());
      printResponse(e.toString());
    }
  }

  Future getSettings({
    required int moderatorId,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(GetAccessLoadingState());
      await networkService.get(
        url: EndPoints.getAccess,
        query: {
          "moderatorId": moderatorId,
        },
      ).then((value) {
        accessResponse = AccessResponse.fromJson(value.data);
        settingsModelGlobal = accessResponse!.settings;
        printLog(value.data.toString());
        afterSuccess();
        emit(GetAccessSuccessState());
      });
    } on DioError catch (n) {
      emit(GetAccessErrorState());
      printError(n.toString());
    } catch (e) {
      emit(GetAccessErrorState());
      printError(e.toString());
    }
  }

  Future updateAdminComment({
    required int userId,
    required String comment,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(ModeratorCommentLoadingState());
      await networkService.post(url: EndPoints.userAdminComment, body: {
        'id': userId,
        'comment': comment,
      }).then((value) {
        globalResponse = GlobalResponse.fromJson(value.data);
        DefaultToast.showMyToast(globalResponse!.message.toString());
        emit(ModeratorCommentSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(ModeratorCommentErrorState());
      printError(n.toString());
    } catch (e) {
      emit(ModeratorCommentErrorState());
      printError(e.toString());
    }
  }
}
