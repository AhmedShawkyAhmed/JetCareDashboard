import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/end_points.dart';
import 'package:jetboard/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetboard/src/data/models/settings_model.dart';
import 'package:jetboard/src/data/models/user_model.dart';
import 'package:jetboard/src/data/network/requests/user_request.dart';
import 'package:jetboard/src/data/network/responses/access_response.dart';
import 'package:jetboard/src/data/network/responses/user_response.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';

part 'moderator_state.dart';

class ModeratorCubit extends Cubit<ModeratorState> {
  ModeratorCubit() : super(ModeratorInitial());

  static ModeratorCubit get(context) => BlocProvider.of(context);

  UserResponse? getUserResponse,
      addUserResponse,
      deleteUserResponse,
      updateUserResponse,
      updateUserStatusResponse;
  AccessResponse? accessResponse;
  List<String> roleList = [];
  List<UserModel> userList = [];
  List<SettingsModel> settings = [];
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
          "type": "moderator",
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
          'role': "moderator",
        },
      ).then((value) {
        DefaultToast.showMyToast(value.data['message']);
        if (value.data['status'] == 200) {
          afterSuccess();
        } else {
          onError();
        }
        addUserResponse = UserResponse.fromJson(value.data);
        userList.insert(0, addUserResponse!.userModell!);
        listCount += 1;
        createAccess(id: addUserResponse!.userModell!.id);
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
    required UserRequset userRequest,
    required int index,
  }) async {
    try {
      emit(ChangeUserLoadingState());
      await DioHelper.postData(
        url: EndPoints.changeAccountStatus,
        body: {
          'id': userRequest.id,
          'active': userRequest.active,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        updateUserStatusResponse = UserResponse.fromJson(myData);
        userList[index].active = userRequest.active!;
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

  Future createAccess({required int id}) async {
    try {
      emit(CreateAccessLoadingState());
      await DioHelper.postData(
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
      await DioHelper.postData(
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
      await DioHelper.getData(
        url: EndPoints.getAccess,
        query: {
          "moderatorId": moderatorId,
        },
      ).then((value) {
        accessResponse = AccessResponse.fromJson(value.data);
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
}
