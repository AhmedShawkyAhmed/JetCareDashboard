class CalenderRequest {
  int calenderId;
  List<int> periodId;
  int areaId;

  CalenderRequest({
    required this.areaId,
    required this.periodId,
    required this.calenderId,
  });
}
