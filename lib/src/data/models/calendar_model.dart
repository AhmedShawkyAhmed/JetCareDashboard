class CalendarModel {
  int id;
  int areaId;
  String month;
  String year;
  String date;
  int requests;
  int price;
  List<Periods> periods;

  CalendarModel(
      {required this.id,
      required this.areaId,
      required this.month,
      required this.year,
      required this.date,
      required this.requests,
      required this.price,
      required this.periods});

  factory CalendarModel.fromJson(Map<String, dynamic> json) => CalendarModel(
        id: json['id'],
        areaId: json['areaId'],
        month: json['month'],
        year: json['year'],
        date: json['date'],
        requests: json['requests'],
        price: json['price'],
        periods: json["periods"] != null
            ? List<Periods>.from(
                json["periods"].map((x) => Periods.fromJson(x)))
            : json["periods"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['areaId'] = areaId;
    data['month'] = month;
    data['year'] = year;
    data['date'] = date;
    data['price'] = price;
    data["periods"] = List<dynamic>.from(periods.map((x) => x.toJson()));
    return data;
  }
}

class Periods {
  int id;
  String from;
  String to;
  int relationId;
  int available;

  Periods({
   required this.id,
   required this.from,
   required this.to,
   required this.relationId,
   required this.available,
  });

  factory Periods.fromJson(Map<String, dynamic> json) =>
      Periods(
        id: json['id'],
        from: json['from'],
        to: json['to'],
        relationId: json['relationId'],
        available: json['available'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from'] = from;
    data['to'] = to;
    data['relationId'] = relationId;
    data['available'] = available;

    return data;
  }
}
