class TransactionData {
  int? id;
  int? userId;
  int? clientId;
  int? clientInstitutionId;
  String? type;
  String? status;
  String? createdAt;
  List<dynamic>? items;

  TransactionData({
    this.id,
    this.userId,
    this.clientId,
    this.clientInstitutionId,
    this.type,
    this.status,
    this.createdAt,
    this.items,
  });
}
