import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/network_service.dart';
import 'package:jetboard/src/core/services/cache_service.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/data/network/requests/auth_request.dart';
import 'package:jetboard/src/data/network/responses/auth_response.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.networkService) : super(AuthInitial());
  NetworkService networkService;

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
      await networkService.post(url: EndPoints.adminLogin, body: {
        'email': authRequest.email,
        'password': authRequest.password,
      }).then((value) {
        printResponse(value.data.toString());
        adminResponse = AdminResponse.fromJson(value.data);
        if (adminResponse!.status == 200) {
          CacheService.add(key: 'id', value: adminResponse!.accountModel!.id);
          CacheService.add(
              key: 'name', value: adminResponse!.accountModel!.name);
          CacheService.add(
              key: 'phone', value: adminResponse!.accountModel!.phone);
          CacheService.add(
              key: 'email', value: adminResponse!.accountModel!.email);
          CacheService.add(
              key: 'role', value: adminResponse!.accountModel!.role);
          CacheService.add(
              key: 'active', value: adminResponse!.accountModel!.active);
          // CacheHelper.saveDataSharedPreference(
          //     key: SharedPreferenceKeys.fcm, value: adminResponse!.accountModel!.fcm);
          // updateFCM(
          //     id: adminResponse!.accountModel!.id, fcm: pushToken == null?"empty":pushToken.toString());
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
      await networkService.post(
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
