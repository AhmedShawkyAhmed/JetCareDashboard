import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/main.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/end_points.dart';
import 'package:jetboard/src/data/data_provider/local/cache_helper.dart';
import 'package:jetboard/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetboard/src/data/network/requests/auth_request.dart';
import 'package:jetboard/src/data/network/responses/auth_response.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  AdminResponse? adminResponse;
  GlobalResponse? fcmResponse;
  bool pass = true;

  void isPassword() {
    pass = !pass;
    emit(ChangePasswordState());
  }

  Future login({
    required AuthRequest authRequest,
    required VoidCallback admin,
    required VoidCallback moderator,
    required VoidCallback afterFail,
  }) async {
    try {
      emit(LoginLoadingState());
      await DioHelper.postData(url: EndPoints.adminLogin, body: {
        'email': authRequest.email,
        'password': authRequest.password,
      }).then((value) {
        adminResponse = AdminResponse.fromJson(value.data);
        if (adminResponse!.status == 200) {
          CacheHelper.saveDataSharedPreference(
              key: 'id', value: adminResponse!.accountModel!.id);
          CacheHelper.saveDataSharedPreference(
              key: 'name', value: adminResponse!.accountModel!.name);
          CacheHelper.saveDataSharedPreference(
              key: 'phone', value: adminResponse!.accountModel!.phone);
          CacheHelper.saveDataSharedPreference(
              key: 'email', value: adminResponse!.accountModel!.email);
          CacheHelper.saveDataSharedPreference(
              key: 'role', value: adminResponse!.accountModel!.role);
          CacheHelper.saveDataSharedPreference(
              key: 'active', value: adminResponse!.accountModel!.active);
          updateFCM(
              id: adminResponse!.accountModel!.id, fcm: pushToken.toString());
          emit(LoginSuccessState());
          if (adminResponse!.accountModel!.role == "admin") {
            admin();
          } else {
            moderator();
          }
        } else {
          afterFail();
        }
      });
    } on DioError catch (n) {
      emit(LoginErrorState());
      printError(n.toString());
    } catch (e) {
      emit(LoginErrorState());
      printError(e.toString());
    }
  }

  Future updateFCM({
    required int id,
    required String fcm,
  }) async {
    try {
      emit(FCMLoadingState());
      await DioHelper.postData(
        url: EndPoints.updateFCM,
        body: {
          'id': id,
          'fcm': fcm,
        },
      ).then((value) {
        fcmResponse = GlobalResponse.fromJson(value.data);
        printSuccess("FCM Response ${fcmResponse!.status.toString()}");
        emit(FCMSuccessState());
      });
    } on DioError catch (n) {
      emit(FCMErrorState());
      printError(n.toString());
    } catch (e) {
      emit(FCMErrorState());
      printError(e.toString());
    }
  }
}
