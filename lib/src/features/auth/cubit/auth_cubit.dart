import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/constants/cache_keys.dart';
import 'package:jetboard/src/core/network/models/key_value_model.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/routing/routes.dart';
import 'package:jetboard/src/core/services/cache_service.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/globals.dart';
import 'package:jetboard/src/core/shared/views/indicator_view.dart';
import 'package:jetboard/src/core/shared/widgets/toast.dart';
import 'package:jetboard/src/core/utils/enums.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/auth/data/models/tab_access_model.dart';
import 'package:jetboard/src/features/auth/data/models/user_model.dart';
import 'package:jetboard/src/features/auth/data/repo/auth_repo.dart';
import 'package:jetboard/src/features/auth/data/requests/fcm_request.dart';
import 'package:jetboard/src/features/auth/data/requests/login_request.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.repo) : super(AuthenticateInitial());
  AuthRepo repo;

  bool password = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void isPassword() {
    password = !password;
  }

  Future login() async {
    if (emailController.text == "") {
      DefaultToast.showMyToast("Enter Your Email");
      return;
    }
    if (passwordController.text == "") {
      DefaultToast.showMyToast("Enter Your Password");
      return;
    }
    IndicatorView.showIndicator();
    emit(LoginLoading());
    var response = await repo.login(
      request: LoginRequest(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(LoginSuccess());
        CacheService.add(key: CacheKeys.token, value: response.data!.token);
        if (CacheService.get(key: CacheKeys.fcm) != null) {
          await updateFCM(id: response.data!.id!);
        }
        await getProfile();
      },
      failure: (NetworkExceptions error) {
        emit(LoginFailure());
        NavigationService.pop();
        error.showError();
      },
    );
  }

  Future updateFCM({
    required int id,
  }) async {
    emit(FCMLoading());
    var response = await repo.fcm(
      request: FCMRequest(
        id: id,
        fcm: CacheService.get(key: CacheKeys.fcm),
      ),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(FCMSuccess());
        printSuccess("FCM Response ${response.status}");
      },
      failure: (NetworkExceptions error) {
        emit(FCMFailure());
        error.showError();
      },
    );
  }

  Future getProfile({
    bool isNewAccount = false,
  }) async {
    emit(ProfileLoading());
    var response = await repo.profile();
    response.when(
      success: (NetworkBaseModel response) async {
        Globals.userData = response.data!;
        printSuccess(Globals.userData.role);
        if (Globals.userData.role == Roles.admin ||
            Globals.userData.role == Roles.moderator) {
          await setAdminTabAccess(role: Globals.userData.role!);
        } else {
          NavigationService.pushNamedAndRemoveUntil(
            Routes.login,
            (route) => false,
          );
        }
        emit(ProfileSuccess());
      },
      failure: (NetworkExceptions error) {
        CacheService.clear();
        NavigationService.pushReplacementNamed(Routes.login);
        error.showError();
        emit(ProfileFailure());
      },
    );
  }

  Future setAdminTabAccess({
    required Roles role,
  }) async {
    if (role == Roles.admin) {
      Globals.tabAccessData = TabAccessModel(
        category: KeyValueModel(key: "category",value: true),
        ads: KeyValueModel(key: "ads",value: true),
        area: KeyValueModel(key: "area",value: true),
        clients: KeyValueModel(key: "clients",value: true),
        corporateItems: KeyValueModel(key: "corporate_items",value: true),
        corporates: KeyValueModel(key: "corporates",value: true),
        crews: KeyValueModel(key: "crews",value: true),
        equipment: KeyValueModel(key: "equipment",value: true),
        equipmentSchedule: KeyValueModel(key: "equipment_schedule",value: true),
        extrasItems: KeyValueModel(key: "extras_items",value: true),
        governorate: KeyValueModel(key: "governorate",value: true),
        info: KeyValueModel(key: "info",value: true),
        items: KeyValueModel(key: "items",value: true),
        moderators: KeyValueModel(key: "moderators",value: true),
        notifications: KeyValueModel(key: "notifications",value: true),
        offers: KeyValueModel(key: "offers",value: true),
        orders: KeyValueModel(key: "orders",value: true),
        periods: KeyValueModel(key: "periods",value: true),
        support: KeyValueModel(key: "support",value: true),
      );
      NavigationService.pushNamedAndRemoveUntil(
        Routes.layout,
        (route) => false,
      );
    } else {
      emit(TabAccessLoading());
      var response = await repo.getTabAccess();
      response.when(
        success: (NetworkBaseModel response) async {
          NavigationService.pushNamedAndRemoveUntil(
            Routes.layout,
            (route) => false,
          );
          emit(TabAccessSuccess());
        },
        failure: (NetworkExceptions error) {
          error.showError();
          emit(TabAccessFailure());
        },
      );
    }
  }

  Future logout() async {
    emit(LogoutLoading());
    var response = await repo.logout();
    response.when(
      success: (NetworkBaseModel response) async {
        CacheService.clear();
        Globals.userData = UserModel();
        NavigationService.pushNamedAndRemoveUntil(
          Routes.login,
          (route) => false,
        );
        emit(LogoutSuccess());
      },
      failure: (NetworkExceptions error) {
        DefaultToast.showMyToast(error.message);
        emit(LogoutFailure());
        error.showError();
      },
    );
  }
}
