import 'dart:convert';

import 'package:flutter/material.dart';

import '../api/request.dart';
import '../models/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  List<TransactionData> _transactions = [];
  TransactionData transactionDetail = TransactionData();

  List<TransactionData> get transactions => _transactions;

  bool isLoading = false;

  void updateTransactionsData(List<dynamic> dataList) {
    _transactions = dataList
        .map((data) => TransactionData(
        id: data['id'],
        type: data['type'],
        title: data['title'],
        status: data['status'],
        payload: data['payload'],
        date: data['date']))
        .toList();
    isLoading = false;
    notifyListeners();
  }

  void updateTransactionDetail(dynamic dataDetail) {
    transactionDetail = TransactionData(
      id: dataDetail.id,
      type: dataDetail.type,
      payload: dataDetail.payload,
      date: dataDetail.date,
    );
    debugPrint("Trnsaction detail: ${transactionDetail.id}");
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

  getTransactions() async {
    isLoading = true;
    try {
      final response =
      await APIRequest().getRequest(route: "/transactions?type=crypto");

      final decodedResponse = jsonDecode(response.body);
      updateTransactionsData(decodedResponse['transactions']);

    } catch (e,st) {
      isLoading = false;
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
