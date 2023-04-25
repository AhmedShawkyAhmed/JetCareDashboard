class AccountModel {
  int id;
  String name;
  String phone;
  String email;
  String role;
  int active;

  AccountModel(
      {required this.id,
      required this.name,
      required this.phone,
      required this.email,
      required this.role,
      required this.active});

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        role: json['role'],
        active: json['active'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['role'] = role;
    data['active'] = active;
    return data;
  }
}
