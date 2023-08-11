import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/end_points.dart';
import 'package:jetboard/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetboard/src/data/models/user_model.dart';
import 'package:jetboard/src/data/network/requests/user_request.dart';
import 'package:jetboard/src/data/network/responses/crew_area_response.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';
import 'package:jetboard/src/data/network/responses/user_response.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';

part 'crew_state.dart';

class CrewCubit extends Cubit<CrewState> {
  CrewCubit() : super(CrewInitial());

  static CrewCubit get(context) => BlocProvider.of(context);

  CrewAreaResponse? crewAreaResponse;
  GlobalResponse? globalResponse;
  List<int> areaIds = [];
  List<int> crewAreasIds = [];
  UserResponse? getUserResponse,
      addUserResponse,
      deleteUserResponse,
      updateUserResponse,
      updateUserStatusResponse;
  List<String> roleList = [];
  List<UserModel> userList = [];
  int listCount = 0;
  int index = 0;
  bool pass = true;

  void isPassword() {
    pass = !pass;
    emit(ChangePasswordState());
  }

  void switched(int index) {
    userList[index].active == 1
        ? userList[index].active = 0
        : userList[index].active = 1;
    printSuccess(index.toString());
    emit(UserSwitchState());
  }

  Future getUser({String? keyword}) async {
    getUserResponse = null;
    userList.clear();
    listCount = 0;
    try {
      emit(UserLoadingState());
      await DioHelper.getData(
        url: EndPoints.getAccounts,
        query: {
          "type": "crew",
          "keyword": keyword,
        },
      ).then((value) {
        emit(UserSuccessState());
        getUserResponse = UserResponse.fromJson(value.data);
        userList.addAll(getUserResponse!.userModel!);
        listCount = getUserResponse!.userModel!.length;
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(UserErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UserErrorState());
      printError(e.toString());
    }
  }

  Future addUser({
    required UserRequset userRequest,
    required VoidCallback afterSuccess,
    required VoidCallback onError,
  }) async {
    try {
      emit(AddUserLoadingState());
      await DioHelper.postData(
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
        if(value.data['status'] == 200){
          afterSuccess();
        }else{
          onError();
        }
        addUserResponse = UserResponse.fromJson(value.data);
        userList.insert(0, addUserResponse!.userModell!);
        listCount += 1;
        emit(AddUserSuccessState());
      });
    } on DioError catch (n) {
      emit(AddUserErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddUserErrorState());
      printError(e.toString());
    }
  }

  Future deleteUser({required UserModel userModel}) async {
    try {
      emit(DeleteUserLoadingState());
      await DioHelper.postData(
        url: EndPoints.deleteAccount,
        body: {
          'id': userModel.id,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        deleteUserResponse = UserResponse.fromJson(myData);
        userList.remove(userModel);
        listCount -= 1;
        emit(DeleteUserSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(DeleteUserErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(DeleteUserErrorState());
      printResponse(e.toString());
    }
  }

  Future updateUserStatus({
    required UserRequset userRequset,
    required int indexs,
  }) async {
    try {
      emit(ChangeUserLoadingState());
      await DioHelper.postData(
        url: EndPoints.changeAccountStatus,
        body: {
          'id': userRequset.id,
          'active': userRequset.active,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        updateUserStatusResponse = UserResponse.fromJson(myData);
        userList[indexs].active = userRequset.active!;
        emit(ChangeUserSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(ChangeUserErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(ChangeUserErrorState());
      printResponse(e.toString());
    }
  }

  Future updateAdminComment({
    required int userId,
    required String comment,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(UserCommentLoadingState());
      await DioHelper.postData(url: EndPoints.userAdminComment, body: {
        'id': userId,
        'comment': comment,
      }).then((value) {
        globalResponse = GlobalResponse.fromJson(value.data);
        DefaultToast.showMyToast(globalResponse!.message.toString());
        emit(UserCommentSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(UserCommentErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UserCommentErrorState());
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
      await DioHelper.getData(
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
      await DioHelper.postData(
        url: EndPoints.addAreaToCrew,
        body: {
          'crewId': crewId,
          'areaId': areaId,
        },
      ).then((value) {
        printLog(value.data['message']);
        printLog(value.data['id'].toString());
        crewAreasIds.insert(0,value.data['id']);
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
      await DioHelper.postData(
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
