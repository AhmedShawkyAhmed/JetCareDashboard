class OrderRequest {
  num periodId, addressId,userId;
  String date, total,price,shipping;
  String? comment;

  OrderRequest({
    required this.userId,
    required this.total,
    required this.price,
    required this.shipping,
    required this.addressId,
    required this.periodId,
    required this.date,
    this.comment,
  });
}
