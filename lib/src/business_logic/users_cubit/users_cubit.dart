import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/data/models/user_model.dart';
import 'package:jetboard/src/data/network/requests/user_request.dart';
import 'package:jetboard/src/data/network/responses/role_response.dart';
import 'package:jetboard/src/data/network/responses/user_response.dart';
import 'package:meta/meta.dart';

import '../../constants/constants_methods.dart';
import '../../constants/end_points.dart';
import '../../data/data_provider/remote/dio_helper.dart';
import '../../presentation/widgets/toast.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersCubitInitial());

  static UsersCubit get(context) => BlocProvider.of(context);
  RoleResponse? roleResponse;
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

  Future getUser({String? type, keyword}) async {
    userList.clear();
    listCount = 0;
    try {
      emit(UserLodingState());
      await DioHelper.getData(
        url: EndPoints.getAccounts,
        query: {
          "type": type,
          "keyword": keyword,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        getUserResponse = UserResponse.fromJson(myData);
        userList.addAll(getUserResponse!.userModel!);

        listCount = getUserResponse!.userModel!.length;
        emit(UserSuccessState());
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

  Future getRoles() async {
    try {
      emit(RoleUserLodingState());
      await DioHelper.getData(
        url: EndPoints.getRole,
      ).then((value) {
        printSuccess(value.data.toString());
        final myData = Map<String, dynamic>.from(value.data);
        roleResponse = RoleResponse.fromJson(myData);
        for (var i = 0; i < roleResponse!.infoModel!.length; i++) {
          roleList.add(roleResponse!.infoModel![i].titleEn.toString());
        }
        roleList.insert(0, 'All');
        emit(RoleUserSuccessState());
        printResponse(value.data.toString());
      });
    } on DioError catch (n) {
      emit(RoleUserErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(RoleUserErrorState());
      printResponse(e.toString());
    }
  }

  Future addUser({
    required UserRequset userRequset,
  }) async {
    printSuccess(userRequset.name.toString());
    printSuccess(userRequset.phone.toString());
    printSuccess(userRequset.email.toString());
    printSuccess(userRequset.role.toString());
    try {
      emit(AddUserLodingState());
      await DioHelper.postData(
        url: EndPoints.register,
        body: {
          'name': userRequset.name,
          'phone': userRequset.phone,
          'email': userRequset.email,
          'password': userRequset.password,
          'role': userRequset.role,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        addUserResponse = UserResponse.fromJson(myData);
        userList.insert(0, addUserResponse!.userModell!);
        listCount += 1;
        emit(AddUserSuccessState());
        DefaultToast.showMyToast(value.data['message']);
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
      emit(DeleteUserLodingState());
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

  Future updateUser({
    required UserRequset userRequset,
    required int index,
  }) async {
    printSuccess(userRequset.id.toString());
    printSuccess(userRequset.name.toString());
    printSuccess(userRequset.phone.toString());
    printSuccess(userRequset.email.toString());
    printSuccess(userRequset.role.toString());
    printSuccess(userRequset.fcm.toString());
    try {
      emit(UpdateUserLodingState());
      await DioHelper.postData(
        url: EndPoints.updateAccount,
        body: {
          'id': userRequset.id,
          'name': userRequset.name,
          'phone': userRequset.phone,
          'email': userRequset.email,
          'role': userRequset.role,
        },
      ).then((value) {
        printSuccess(value.toString());
        final myData = Map<String, dynamic>.from(value.data);
        updateUserResponse = UserResponse.fromJson(myData);
        userList[index] = updateUserResponse!.userModell!;
        emit(UpdateUserSuccessState());
        DefaultToast.showMyToast(value.data['message']);
      });
    } on DioError catch (n) {
      emit(UpdateUserErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UpdateUserErrorState());
      printError(e.toString());
    }
  }

  Future updateUserStatus({
    required UserRequset userRequset,
    required int indexs,
  }) async {
    try {
      emit(ChangeUserLodingState());
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
}
