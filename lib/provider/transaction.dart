import 'package:flutter/material.dart';
import 'package:elcrypto/models/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  List<TransactionData> _transactions = [];
  TransactionData transactionDetail = TransactionData();

  List<TransactionData> get transactions => _transactions;

  void updateTransactionsData(List<dynamic> dataList) {
    _transactions = dataList
        .map((data) => TransactionData(
            id: data['id'],
            type: data['type'],
            payload: data['payload'],
            date: data['date']))
        .toList();
    debugPrint("provider transactions: $_transactions");
    notifyListeners();
  }

  void updateTransactionDetail(dynamic dataDetail) {
    transactionDetail = TransactionData(
      id: dataDetail.id,
      type: dataDetail.type,
      payload: dataDetail.payload,
      date: dataDetail.date,
    );
    notifyListeners();
  }

  void updateTransactionDetailUsingBrackets(dynamic dataDetail) {
    transactionDetail = TransactionData(
      id: dataDetail['id'],
      type: dataDetail['type'],
      payload: dataDetail['payload'],
      date: dataDetail['date'],
    );
    notifyListeners();
  }
}
