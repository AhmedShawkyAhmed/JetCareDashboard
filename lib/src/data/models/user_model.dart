class UserModel {
  int id;
  String name;
  String phone;
  String email;
  num? rate;
  String role;
  int? accepted;
  int? rejected;
  String? fcm;
  int active;
  

  UserModel(
      {required this.id,
      required this.name,
      required this.phone,
      required this.email,
      required this.role,
      required this.active,
      this.rate,
      this.accepted,
      this.rejected,
      this.fcm,
      });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        role: json['role'],
        rate: json['rate'],
        accepted: json['accepted'],
        rejected: json['rejected'],
        fcm: json['fcm'],
        active: json['active'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['role'] = role;
    data['rate'] = rate;
    data['accepted'] = accepted;
    data['rejected'] = rejected;
    data['rejected'] = rejected;
    data['fcm'] = fcm;
    return data;
  }
}
