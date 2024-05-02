class TransactionData {
  int? id;
  String? type;
  dynamic payload;
  String? date;

  TransactionData({
    this.id,
    this.type,
    this.payload,
    this.date
  });
}
