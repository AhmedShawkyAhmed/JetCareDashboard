import 'package:jetboard/src/data/models/crew_area_model.dart';

class CrewAreaResponse {
  int? status;
  List<CrewAreaModel>? areas;
  List<CrewAreaModel>? crews;

  CrewAreaResponse({
    this.status,
    this.areas,
    this.crews,
  });

  factory CrewAreaResponse.fromJson(Map<String, dynamic> json) =>
      CrewAreaResponse(
        status: json['status'],
        areas: json["areas"] != null
            ? List<CrewAreaModel>.from(
                json["areas"].map((x) => CrewAreaModel.fromJson(x)))
            : [],
        crews: json["crews"] != null
            ? List<CrewAreaModel>.from(
            json["crews"].map((x) => CrewAreaModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "areas": List<dynamic>.from(areas!.map((e) => e.toJson())),
        "crews": List<dynamic>.from(crews!.map((e) => e.toJson())),
      };
}
