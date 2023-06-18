class EquipmentModel {
  int? id;
  String? code;
  String? name;
  int? active;

  EquipmentModel({this.id, this.code, this.name, this.active});

  factory EquipmentModel.fromJson(Map<String, dynamic> json) => EquipmentModel(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        active: json['active'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['active'] = active;
    return data;
  }
}
