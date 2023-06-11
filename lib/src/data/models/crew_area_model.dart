import 'package:jetboard/src/data/models/area_model.dart';
import 'package:jetboard/src/data/models/orders_model.dart';

class CrewAreaModel {
  int? id;
  AreaModel? area;
  User? crew;

  CrewAreaModel({
    this.id,
    this.area,
    this.crew,
  });
  factory CrewAreaModel.fromJson(Map<String, dynamic> json) => CrewAreaModel(
    id: json['id'] ?? 0,
    area: json["area"] != null
        ? AreaModel.fromJson(json["area"])
        : null,
    crew: json["crew"] != null
        ? User.fromJson(json["crew"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'area': area,
    'crew': crew,
  };
}
