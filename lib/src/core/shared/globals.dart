import 'dart:async';

import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/auth/data/models/tab_access_model.dart';
import 'package:jetboard/src/features/auth/data/models/user_model.dart';

class Globals {
  Globals._();

  static const _runtimeType = Globals;

  // ---------------- [user data] ---------------------
  static final StreamController<UserModel> _userStreamController =
      StreamController<UserModel>.broadcast();
  static UserModel _userData = UserModel();

  static Stream<UserModel> userDataStream = _userStreamController.stream;

  static UserModel get userData => _userData;

  static void updateUserStream({UserModel? value}) {
    if (value != null) {
      _userData = value;
    }
    _userStreamController.add(_userData);
    printSuccess('User data updated', runtimeType: _runtimeType);
  }

  static set userData(UserModel value) {
    updateUserStream(value: value);
  }

  // ---------------- [tab access data] ---------------------
  static final StreamController<TabAccessModel> _tabAccessStreamController =
      StreamController<TabAccessModel>.broadcast();
  static TabAccessModel _tabAccessData = TabAccessModel();

  static Stream<TabAccessModel> tabAccessDataStream =
      _tabAccessStreamController.stream;

  static TabAccessModel get tabAccessData => _tabAccessData;

  static void updateTabAccessStream({TabAccessModel? value}) {
    if (value != null) {
      _tabAccessData = value;
    }
    _tabAccessStreamController.add(_tabAccessData);
    printSuccess('Tab Access data updated', runtimeType: _runtimeType);
  }

  static set tabAccessData(TabAccessModel value) {
    updateTabAccessStream(value: value);
  }
}
