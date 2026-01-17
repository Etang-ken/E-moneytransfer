import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../api/request.dart';
import '../models/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  List<TransactionData> _transactions = [];
  TransactionData transactionDetail = TransactionData();
  bool lockApp = false;

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
      dynamic data = await PackageInfo.fromPlatform();


      final response = await APIRequest().getRequest(route: "/transactions?type=crypto");

      final decodedResponse = jsonDecode(response.body);
      print("//////");

      lockApp = ( data.version.compareTo(decodedResponse['version']['elcrypto'])) < 0;

      updateTransactionsData(decodedResponse['transactions']);


    } catch (e,st) {
      isLoading = false;
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
