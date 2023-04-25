import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/end_points.dart';
import 'package:jetboard/src/data/data_provider/local/cache_helper.dart';
import 'package:jetboard/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetboard/src/data/network/requests/auth_request.dart';
import 'package:jetboard/src/data/network/responses/auth_response.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  AdminResponse? adminResponse;
  bool pass = true;

  void isPassword (){
    pass =!pass;
    emit(ChangePasswordState());
  }

  Future login({
   required AuthRequest authRequest,
required VoidCallback afterSuccess,
    required VoidCallback afterFail,
  }) async {
    try {
      emit(LoginLodingState());
      await DioHelper.postData(url: EndPoints.adminLogin, body: {
        'email': authRequest.email,
        'password': authRequest.password,
      }).then((value) {
        adminResponse = AdminResponse.fromJson(value.data);
         if(adminResponse!.status == 200){
          emit(LoginSuccessState());
          afterSuccess();
          CacheHelper.saveDataSharedPreference(key: 'id', value: adminResponse!.accountModel!.id);
          CacheHelper.saveDataSharedPreference(key: 'name', value: adminResponse!.accountModel!.name);
          CacheHelper.saveDataSharedPreference(key: 'phone', value: adminResponse!.accountModel!.phone);
          CacheHelper.saveDataSharedPreference(key: 'email', value: adminResponse!.accountModel!.email);
          CacheHelper.saveDataSharedPreference(key: 'role', value: adminResponse!.accountModel!.role);
          CacheHelper.saveDataSharedPreference(key: 'active', value: adminResponse!.accountModel!.active);
          }else{
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
}
