class SupportModel {
  int id;
  String? name;
	String? contact;
	String? subject;
	String? message;
	String? adminComment;

  SupportModel({
   required this.id,
    this.name,
    this.contact,
    this.subject,
    this.message,
    this.adminComment,

  });

factory  SupportModel.fromJson(Map<String, dynamic> json) => SupportModel
    (
    id : json['id'],
    name: json['name'] ?? "",
  contact: json['contact'] ?? "",
    subject: json['subject'] ?? "",
    message: json['message'] ?? "",
  adminComment: json['adminComment'] ?? "",
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['contact'] = contact;
    data['subject'] = subject;
    data['message'] = message;
    data['adminComment'] = adminComment;

    return data;
  }
}
