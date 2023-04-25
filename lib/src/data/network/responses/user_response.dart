import 'package:jetboard/src/data/models/user_model.dart';

class UserResponse {
  int? status;
  List<UserModel>? userModel;
  UserModel? userModell;


  UserResponse({this.status, this.userModel, this.userModell});

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        status: json['status'],
        userModel: json["accountList"] != null
            ? List<UserModel>.from(json["accountList"].map((x)=> UserModel.fromJson(x)))
            :[],
        userModell: json['account'] != null ? UserModel.fromJson(json["account"])
        :null,
      );

  Map<String, dynamic> toJson() => {
    "status":status,
    "accountList":List<dynamic>.from(userModel!.map((e) => e.toJson())),
    "account": userModell
  };
}


