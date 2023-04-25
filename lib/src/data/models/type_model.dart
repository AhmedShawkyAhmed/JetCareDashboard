class TypeModel {
  String type;

  TypeModel({
    required this.type,
  });

  factory TypeModel.fromJson(Map<String, dynamic> json) => TypeModel(
        type: json['type'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};

    data['type'] = type;
    return data;
  }
}
