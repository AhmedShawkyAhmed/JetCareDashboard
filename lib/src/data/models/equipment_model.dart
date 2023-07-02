class EquipmentModel {
  int? id;
  String? code;
  String? name;
  int? active;

  EquipmentModel({
    this.id,
    this.code,
    this.name,
    this.active,
  });

  factory EquipmentModel.fromJson(Map<String, dynamic> json) => EquipmentModel(
        id: json['id'] ?? 0,
        code: json['code'] ?? "",
        name: json['name'] ?? "",
        active: json['active'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'name': name,
        'active': active,
      };
}
