class SupportModel {
  int id;
  String name;
	String contact;
	String subject;
	String message;

  SupportModel({
   required this.id,
   required this.name,
   required this.contact,
   required this.subject,
   required this.message,
   
  });

factory  SupportModel.fromJson(Map<String, dynamic> json) => SupportModel
    (
    id : json['id'],
    name: json['name'],
  contact: json['contact'],
    subject: json['subject'],
    message: json['message'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['contact'] = contact;
    data['subject'] = subject;
    data['message'] = message;
    
    return data;
  }
}
