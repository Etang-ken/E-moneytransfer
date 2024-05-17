class TransactionData {
  int? id;
  String? type;
  dynamic payload;
  String? date;
  String? title;
  String? status;

  TransactionData({
    this.id,
    this.type,
    this.payload,
    this.title,
    this.status,
    this.date
  });
}
