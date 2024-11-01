import 'dart:convert';


import 'package:cinetpay/cinetpay.dart';
import 'package:elcrypto/api/url.dart';
import 'package:elcrypto/helper/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/transaction.dart';

class LaunchCinetpay extends StatefulWidget {
  dynamic formData;
  int amount;

  LaunchCinetpay(this.formData, this.amount);

  @override
  State<LaunchCinetpay> createState() => _LaunchCinetpayState(formData, amount);
}

class _LaunchCinetpayState extends State<LaunchCinetpay> {
  dynamic formData;

  int amount;

  _LaunchCinetpayState(this.formData, this.amount);

  final String transactionId = DateTime.now().toString();
  IconData? icon;
  Map<String, dynamic>? response;
  Color? color;
  bool show = false;
  String? message;

  double rate = 0;

  @override
  Widget build(BuildContext context) {
    print(amount);
    return CinetPayCheckout(
      title: 'Payment Checkout',
      titleStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Colors.white,
          ),
      titleBackgroundColor: AppUtils.PrimaryColor,
      configData: <String, dynamic>{
        'apikey': AppUrl.cinetpayApiKey,
        'site_id': int.parse(AppUrl.cinetpaySiteId),
        'notify_url': "${AppUrl.appUrl}api/cinetpay/callback"
      },
      paymentData: <String, dynamic>{
        'transaction_id': transactionId,
        'amount': amount,
        'currency': "XAF",
        'channels': 'MOBILE_MONEY',
        'metadata': jsonEncode(formData),
        'description': 'Buy Crypto from ElCrypto',
      },
      waitResponse: (data) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Provider.of<TransactionProvider>(context, listen: false).getTransactions();
      },
      onError: (data) {
        print("////////////");
        print(data);
        if (mounted) {
          setState(() {
            response = data;
            message = response!['description'];
            icon = Icons.warning_rounded;
            color = AppUtils.PrimaryColor;
            show = true;
            Navigator.pop(context);
          });
        }
      },
    );
  }
}
