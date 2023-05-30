import 'package:jetboard/src/data/models/area_model.dart';

class StatesResponse {
  int? status;
  List<AreaModel>? statesList;

  StatesResponse({
    this.status,
    this.statesList,
  });

  factory StatesResponse.fromJson(Map<String, dynamic> json) => StatesResponse(
        status: json['status'],
        statesList: json["states"] != null
            ? List<AreaModel>.from(
                json["states"].map((x) => AreaModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "states": List<dynamic>.from(statesList!.map((e) => e.toJson())),
      };
}
