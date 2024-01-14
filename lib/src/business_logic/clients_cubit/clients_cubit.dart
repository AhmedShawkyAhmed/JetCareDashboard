import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/data/models/user_model.dart';
import 'package:jetboard/src/data/network/requests/user_request.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';
import 'package:jetboard/src/data/network/responses/role_response.dart';
import 'package:jetboard/src/data/network/responses/user_response.dart';
import '../../constants/constants_methods.dart';
import '../../constants/end_points.dart';
import '../../data/data_provider/remote/dio_helper.dart';
import '../../presentation/widgets/toast.dart';
part 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit() : super(UsersCubitInitial());

  static ClientsCubit get(context) => BlocProvider.of(context);
  RoleResponse? roleResponse;
  GlobalResponse? globalResponse;
  UserResponse? getUserResponse,
      addUserResponse,
      deleteUserResponse,
      updateUserResponse,
      updateUserStatusResponse;
  List<String> roleList = [];
  List<UserModel> clinetList = [];
  int listCount = 0;
  int index = 0;
  bool pass = true;

  void isPassword() {
    pass = !pass;
    emit(ChangePasswordState());
  }

  void switched(int index) {
    clinetList[index].active == 1
        ? clinetList[index].active = 0
        : clinetList[index].active = 1;
    printSuccess(index.toString());
    emit(UserSwitchState());
  }

  Future getClients({String? keyword}) async {
    getUserResponse = null;
    clinetList.clear();
    listCount = 0;
    try {
      emit(UserLoadingState());
      await DioHelper.getData(
        url: EndPoints.getAccounts,
        query: {
          "type": "client",
          "keyword": keyword,
        },
      ).then((value) {
        emit(UserSuccessState());
        getUserResponse = UserResponse.fromJson(value.data);
        clinetList.addAll(getUserResponse!.userModel!);
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

  Future addClient({
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
          'role': "client",
        },
      ).then((value) {
        DefaultToast.showMyToast(value.data['message']);
        if(value.data['status'] == 200){
          afterSuccess();
        }else{
          onError();
        }
        addUserResponse = UserResponse.fromJson(value.data);
        clinetList.insert(0, addUserResponse!.userModell!);
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

  Future deleteClient({required UserModel userModel}) async {
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
        clinetList.remove(userModel);
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

  Future updateClientStatus({
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
        clinetList[index].active = userRequest.active!;
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

  Future updateClient({
    required UserRequset userRequest,
    required int index,
    required VoidCallback afterSuccess,
    required VoidCallback onError,
  }) async {
    try {
      emit(UpdateUserLoadingState());
      await DioHelper.postData(
        url: EndPoints.updateAccount,
        body: {
          'id': userRequest.id,
          'name': userRequest.name,
          'phone': userRequest.phone,
          'email': userRequest.email,
          'role': userRequest.role,
        },
      ).then((value) {
        DefaultToast.showMyToast(value.data['message']);
        if(value.data['status'] == 200){
          printSuccess(value.toString());
          final myData = Map<String, dynamic>.from(value.data);
          updateUserResponse = UserResponse.fromJson(myData);
          clinetList[index] = updateUserResponse!.userModell!;
          emit(UpdateUserSuccessState());
          afterSuccess();
        }else{
          onError();
          emit(UpdateUserErrorState());
        }
      });
    } on DioError catch (n) {
      emit(UpdateUserErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UpdateUserErrorState());
      printError(e.toString());
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
}
