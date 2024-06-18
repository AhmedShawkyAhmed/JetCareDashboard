import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/network_service.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/data/models/user_model.dart';
import 'package:jetboard/src/data/network/requests/user_request.dart';
import 'package:jetboard/src/data/network/responses/crew_area_response.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';
import 'package:jetboard/src/data/network/responses/user_response.dart';
import 'package:jetboard/src/core/shared/widgets/toast.dart';

part 'crew_state.dart';

class CrewCubit extends Cubit<CrewState> {
  CrewCubit(this.networkService) : super(CrewInitial());

  NetworkService networkService;

  static CrewCubit get(context) => BlocProvider.of(context);

  CrewAreaResponse? crewAreaResponse;
  GlobalResponse? globalResponse;
  List<int> areaIds = [];
  List<int> crewAreasIds = [];
  UserResponse? getCrewResponse,
      addCrewResponse,
      deleteCrewResponse,
      updateCrewResponse,
      updateCrewStatusResponse;
  List<String> roleList = [];
  List<UserModel> crewList = [];
  int listCount = 0;
  int index = 0;
  bool pass = true;

  void isPassword() {
    pass = !pass;
    emit(ChangePasswordState());
  }

  void switched(int index) {
    crewList[index].active == 1
        ? crewList[index].active = 0
        : crewList[index].active = 1;
    printSuccess(index.toString());
    emit(CrewSwitchState());
  }

  Future getCrew({String? keyword}) async {
    getCrewResponse = null;
    crewList.clear();
    listCount = 0;
    try {
      emit(CrewLoadingState());
      await networkService.get(
        url: EndPoints.getAccounts,
        query: {
          "type": "crew",
          "keyword": keyword,
        },
      ).then((value) {
        emit(CrewSuccessState());
        getCrewResponse = UserResponse.fromJson(value.data);
        crewList.addAll(getCrewResponse!.userModel!);
        listCount = getCrewResponse!.userModel!.length;
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(CrewErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CrewErrorState());
      printError(e.toString());
    }
  }

  Future addCrew({
    required UserRequset userRequest,
    required VoidCallback afterSuccess,
    required VoidCallback onError,
  }) async {
    try {
      emit(AddCrewLoadingState());
      await networkService.post(
        url: EndPoints.register,
        body: {
          'name': userRequest.name,
          'phone': userRequest.phone,
          'email': userRequest.email ?? "empty",
          'password': userRequest.password,
          'role': "crew",
        },
      ).then((value) {
        DefaultToast.showMyToast(value.data['message']);
        if (value.data['status'] == 200) {
          afterSuccess();
        } else {
          onError();
        }
        addCrewResponse = UserResponse.fromJson(value.data);
        crewList.insert(0, addCrewResponse!.userModell!);
        listCount += 1;
        emit(AddCrewSuccessState());
      });
    } on DioError catch (n) {
      emit(AddCrewErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddCrewErrorState());
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
      emit(UpdateCrewLoadingState());
      await networkService.post(
        url: EndPoints.updateAccount,
        body: {
          'id': userRequest.id,
          'name': userRequest.name,
          'phone': userRequest.phone,
          'email': userRequest.email,
          'role': "crew",
        },
      ).then((value) {
        DefaultToast.showMyToast(value.data['message']);
        if (value.data['status'] == 200) {
          printSuccess(value.toString());
          final myData = Map<String, dynamic>.from(value.data);
          updateCrewResponse = UserResponse.fromJson(myData);
          crewList[index] = updateCrewResponse!.userModell!;
          emit(UpdateCrewSuccessState());
          afterSuccess();
        } else {
          onError();
          emit(UpdateCrewErrorState());
        }
      });
    } on DioError catch (n) {
      emit(UpdateCrewErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UpdateCrewErrorState());
      printError(e.toString());
    }
  }

  Future deleteCrew({required UserModel userModel}) async {
    try {
      emit(DeleteCrewLoadingState());
      await networkService.post(
        url: EndPoints.deleteAccount,
        body: {
          'id': userModel.id,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        deleteCrewResponse = UserResponse.fromJson(myData);
        crewList.remove(userModel);
        listCount -= 1;
        emit(DeleteCrewSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(DeleteCrewErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(DeleteCrewErrorState());
      printResponse(e.toString());
    }
  }

  Future updateCrewStatus({
    required UserRequset userRequest,
    required int index,
  }) async {
    try {
      emit(ChangeCrewLoadingState());
      await networkService.post(
        url: EndPoints.changeAccountStatus,
        body: {
          'id': userRequest.id,
          'active': userRequest.active,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        updateCrewStatusResponse = UserResponse.fromJson(myData);
        crewList[index].active = userRequest.active!;
        emit(ChangeCrewSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(ChangeCrewErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(ChangeCrewErrorState());
      printResponse(e.toString());
    }
  }

  Future updateAdminComment({
    required int userId,
    required String comment,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(CrewCommentLoadingState());
      await networkService.post(url: EndPoints.userAdminComment, body: {
        'id': userId,
        'comment': comment,
      }).then((value) {
        globalResponse = GlobalResponse.fromJson(value.data);
        DefaultToast.showMyToast(globalResponse!.message.toString());
        emit(CrewCommentSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(CrewCommentErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CrewCommentErrorState());
      printError(e.toString());
    }
  }

  Future getArea({
    required int crewId,
    required VoidCallback afterSuccess,
  }) async {
    areaIds.clear();
    crewAreasIds.clear();
    try {
      emit(CrewAreaLoading());
      await networkService.get(
        url: EndPoints.getCrewAreas,
        query: {
          "crewId": crewId,
        },
      ).then((value) {
        printSuccess(value.data.toString());
        crewAreaResponse = CrewAreaResponse.fromJson(value.data);
        for (int a = 0; a < crewAreaResponse!.areas!.length; a++) {
          areaIds.add(crewAreaResponse!.areas![a].area!.id!);
          crewAreasIds.add(crewAreaResponse!.areas![a].id!);
        }
        emit(CrewAreaSuccess());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(CrewAreaError());
      printError(n.toString());
    } catch (e) {
      emit(CrewAreaError());
      printError(e.toString());
    }
  }

  Future addArea({
    required int crewId,
    required int areaId,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(AddCrewAreaLoading());
      await networkService.post(
        url: EndPoints.addAreaToCrew,
        body: {
          'crewId': crewId,
          'areaId': areaId,
        },
      ).then((value) {
        printLog(value.data['message']);
        printLog(value.data['id'].toString());
        crewAreasIds.insert(0, value.data['id']);
        emit(AddCrewAreaSuccess());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(AddCrewAreaError());
      printError(n.toString());
    } catch (e) {
      emit(AddCrewAreaError());
      printError(e.toString());
    }
  }

  Future deleteArea({
    required int id,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(DeleteCrewAreaLoading());
      await networkService.post(
        url: EndPoints.deleteCrewArea,
        body: {
          'id': id,
        },
      ).then((value) {
        printLog(value.data['message']);
        emit(DeleteCrewAreaSuccess());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(DeleteCrewAreaError());
      printError(n.toString());
    } catch (e) {
      emit(DeleteCrewAreaError());
      printError(e.toString());
    }
  }
}
