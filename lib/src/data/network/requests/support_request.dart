class SupportRequest {
  int id;
  String? name;
	String? email;
	String? subject;
	String? message;
	int active;
  SupportRequest({
  required this.id,
  this.name,
  this.email,
  this.subject,
  this.message,
  required this.active,
  });
}