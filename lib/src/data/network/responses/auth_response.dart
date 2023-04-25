import 'package:jetboard/src/data/models/auth_model.dart';

class AdminResponse {
  int? status;
  AccountModel? accountModel;

  AdminResponse({this.status, this.accountModel});

  factory AdminResponse.fromJson(Map<String, dynamic> json) => AdminResponse(
        status: json['status'],
        accountModel: json["account"] != null
            ? AccountModel.fromJson(json["account"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "account": accountModel,
  };
}
