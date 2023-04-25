class HomeModel {
  num count,active,disabled;

  HomeModel({
    required this.count,
    required this.active,
    required this.disabled,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    count: json['count'] ?? 0,
    active: json['active'] ?? 0,
    disabled: json['disabled'] ?? 0,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};

    data['count'] = count;
    data['active'] = active;
    data['disabled'] = disabled;
    return data;
  }
}
