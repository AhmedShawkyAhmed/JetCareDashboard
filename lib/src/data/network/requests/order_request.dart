class OrderRequest {
  num userId, periodId, addressId, total;
  int? packageId, itemId, calendarId,spaceId;
  String date;
  String? comment;
  List<int> extraIds;

  OrderRequest({
    required this.userId,
    required this.total,
    required this.addressId,
    required this.periodId,
    required this.date,
    this.spaceId,
    this.calendarId,
    this.itemId,
    required this.extraIds,
    this.packageId,
    this.comment,
  });
}
