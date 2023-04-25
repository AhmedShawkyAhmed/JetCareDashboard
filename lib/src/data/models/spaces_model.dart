class SpacesModel {
  int id;
  int? packageId;
  String from;
  String to;
  int active;
  num price;

  SpacesModel({
    required this.id,
    this.packageId,
    required this.from,
    required this.to,
    required this.active,
    required this.price,
  });

  factory SpacesModel.fromJson(Map<String, dynamic> json) => SpacesModel(
        id: json['id'],
        packageId: json['packageId'],
        from: json['from'],
        to: json['to'],
        active: json['active'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};

    data['id'] = id;
    data['packageId'] = packageId;
    data['from'] = from;
    data['to'] = to;
    data['active'] = active;
    data['price'] = price;
    return data;
  }
}
