class CalendarRquest {
  int? id;
  int areaId;
  String month;
  String day;
  String year;
  List<String> date;
  int requests;
  double price;
  CalendarRquest({
    this.id,
   required this.areaId,
   required this.month,
   required this.day,
   required this.year,
   required this.date,
   required this.requests,
   required this.price,
  });
}
