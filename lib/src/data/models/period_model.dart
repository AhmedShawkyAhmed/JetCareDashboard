class PeriodModel {
  int? id;
  String? from;
  String? to;
  int? active;
  int? relationId;

  PeriodModel({
    this.id,
    this.from,
    this.to,
    this.active,
    this.relationId,
  });

  factory PeriodModel.fromJson(Map<String, dynamic> json) => PeriodModel(
        id: json['id'] ?? 0,
        from: json['from'] ?? "",
        to: json['to'] ?? "",
        active: json['active'] ?? 1,
        relationId: json['relationId'] ?? 1,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['from'] = from;
    data['to'] = to;
    data['active'] = active;
    data['relationId'] = relationId;
    return data;
  }
}
