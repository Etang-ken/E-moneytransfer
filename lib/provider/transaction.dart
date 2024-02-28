import 'package:flutter/material.dart';
import 'package:truelife_mobile/models/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  List<TransactionData> _transactions = [];
  TransactionData transactionDetail = TransactionData();

  List<TransactionData> get transactions => _transactions;

  void updateTransactionsData(List<dynamic> dataList) {
    _transactions = dataList
        .map((data) => TransactionData(
              id: data['id'],
              userId: data['user_id'],
              clientId: data['client_id'],
              clientInstitutionId: data['client_institution_id'],
              type: data['type'],
              status: data['status'],
              createdAt: data['created_at'],
              items: data['items'],
            ))
        .toList();

    notifyListeners();
  }

  void updateTransactionDetail(dynamic dataDetail) {
    transactionDetail = TransactionData(
      id: dataDetail.id,
      userId: dataDetail.userId,
      clientId: dataDetail.clientId,
      clientInstitutionId: dataDetail.clientInstitutionId,
      type: dataDetail.type,
      status: dataDetail.status,
      createdAt: dataDetail.createdAt,
      items: dataDetail.items,
    );
  }
}
