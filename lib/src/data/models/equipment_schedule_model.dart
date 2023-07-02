import 'package:jetboard/src/data/models/equipment_model.dart';

class EquipmentScheduleModel {
  int? id;
  String? date;
  String? returned;
  String? createdAt;
  Crew? crew;
  EquipmentModel? equipment;

  EquipmentScheduleModel(
      {this.id,
      this.date,
      this.returned,
      this.createdAt,
      this.crew,
      this.equipment});

    factory EquipmentScheduleModel.fromJson(Map<String, dynamic> json) => EquipmentScheduleModel(
    id : json['id'],
    date : json['date'],
    returned : json['returned'],
    createdAt : json['createdAt'],
    crew: json['crew'] != null ? Crew.fromJson(json['crew']) : null,
    equipment : json['equipment'] != null
        ?  EquipmentModel.fromJson(json['equipment'])
        : null,
    );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['returned'] = returned;
    data['createdAt'] = createdAt;
    if (crew != null) {
      data['crew'] = crew!.toJson();
    }
    if (equipment != null) {
      data['equipment'] = equipment!.toJson();
    }
    return data;
  }
}

class Crew {
  int? id;
  String? name;
  String? phone;
  String? email;

  Crew({this.id, this.name, this.phone, this.email});

  factory Crew.fromJson(Map<String, dynamic> json) => Crew( 
    id : json['id'],
    name : json['name'],
    phone : json['phone'],
    email : json['email'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}
