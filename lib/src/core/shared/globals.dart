import 'dart:async';

import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/data/models/user_model.dart';

class Globals {
  Globals._();

  static const _runtimeType = Globals;

  // ---------------- [user data] ---------------------
  static final StreamController<UserModel> _userStreamController =
      StreamController<UserModel>.broadcast();
  static UserModel _userData = UserModel(id: 1, name: '', phone: '', email: '', role: '', active: 1);

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
}
