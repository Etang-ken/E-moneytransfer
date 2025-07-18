class TransactionData {
  int? id;
  dynamic payload;
  String? date;
  String? title;
  String? status;

  TransactionData({
    this.id,
    this.payload,
    this.title,
    this.status,
    this.date
  });
}
