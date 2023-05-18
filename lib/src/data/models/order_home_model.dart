class OrderHomeModel {
  num count,
      assigned,
      unassigned,
      completed,
      accepted,
      canceled,
      rejected,
      corporate,
      complete,
      confirmed,
      out;

  OrderHomeModel({
    required this.count,
    required this.assigned,
    required this.unassigned,
    required this.completed,
    required this.accepted,
    required this.canceled,
    required this.rejected,
    required this.corporate,
    required this.complete,
    required this.confirmed,
    required this.out,
  });

  factory OrderHomeModel.fromJson(Map<String, dynamic> json) => OrderHomeModel(
        count: json['count'] ?? 0,
        assigned: json['assigned'] ?? 0,
        unassigned: json['unassigned'] ?? 0,
        completed: json['completed'] ?? 0,
        accepted: json['accepted'] ?? 0,
        canceled: json['canceled'] ?? 0,
        rejected: json['rejected'] ?? 0,
        corporate: json['corporate'] ?? 0,
        complete: json['complete'] ?? 0,
    confirmed: json['confirmed'] ?? 0,
        out: json['out'] ?? 0,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['count'] = count;
    data['assigned'] = assigned;
    data['unassigned'] = unassigned;
    data['completed'] = completed;
    data['accepted'] = accepted;
    data['canceled'] = canceled;
    data['rejected'] = rejected;
    data['corporate'] = corporate;
    data['confirmed'] = confirmed;
    data['complete'] = complete;
    data['out'] = out;
    return data;
  }
}
