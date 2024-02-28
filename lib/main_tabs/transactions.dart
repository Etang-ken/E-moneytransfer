import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truelife_mobile/api/request.dart';
import 'package:truelife_mobile/helper/app_utils.dart';
import 'package:truelife_mobile/main_tabs/detail_screens/transaction_details.dart';
import 'package:truelife_mobile/main_tabs/widgets/notification_icon.dart';
import 'package:truelife_mobile/main_tabs/widgets/transaction.dart';
import 'package:truelife_mobile/provider/transaction.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  bool isLoading = false;

  Future<void> getAlltransactions() async {
    if (!mounted) return;
    final TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    if (!mounted) return;
    final hasConnectivity = await hasInternetConnectivity(context);
    if (hasConnectivity) {
      final response = await APIRequest().getRequest(route: '/transaction/all');
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        transactionProvider
            .updateTransactionsData(decodedResponse['transactions']);
        setState(() {
          isLoading = false;
        });
      } else {
        if (!mounted) return;
        AppUtils.showSnackBar(
            context, ContentType.failure, 'Error getting transactions data.');
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAlltransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<TransactionProvider>(builder: (_, data, __) {
          final transactions = data.transactions;
          return Scaffold(
            backgroundColor: AppUtils.SecondaryGrayExtraLight,
            appBar: AppBar(
              backgroundColor: AppUtils.PrimaryColor,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transactions",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.white),
                  ),
                  NotificationIcon(context: context)
                ],
              ),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              margin: const EdgeInsets.only(bottom: 60),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: transactions.isNotEmpty
                          ? transactions.map<Widget>((transaction) {
                              return GestureDetector(
                                onTap: () {
                                  final TransactionProvider
                                      transactionProvider =
                                      Provider.of<TransactionProvider>(context,
                                          listen: false);
                                  transactionProvider
                                      .updateTransactionDetail(transaction);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TransactionDetails(),
                                    ),
                                  );
                                },
                                child: transactionCard(
                                    context,
                                    textCapitalize(transaction.type!),
                                    calculateTotalItemPrice(transaction.items!)
                                        .toString(),
                                    textCapitalize(transaction.status!),
                                    formatDateWithSlash(
                                        transaction.createdAt!)),
                              );
                            }).toList()
                          : [
                              Center(
                                child: Text(
                                  isLoading
                                      ? 'Loading transactions...'
                                      : 'No transaction has been added.',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        if (isLoading) showIsLoading()
      ],
    );
  }
}
