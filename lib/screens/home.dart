import 'dart:convert';

import 'package:eltransfer/api/request.dart';
import 'package:eltransfer/api/url.dart';
import 'package:eltransfer/provider/transaction.dart';
import 'package:eltransfer/screens/detail_screens/add_new_transaction.dart';\
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eltransfer/helper/app_utils.dart';
import 'package:eltransfer/home_nav.dart';
import 'package:eltransfer/screens/detail_screens/client_invoices.dart';
import 'package:eltransfer/screens/notifications.dart';
import 'package:eltransfer/screens/widgets/notification_icon.dart';
import 'package:eltransfer/provider/user.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

enum BorderLeftOrRight { left, right }

class _DashboardState extends State<Dashboard> {
  bool isLoading = false;

  Future<void> getTransactions() async {
    final TransactionProvider transactionProvider =
    Provider.of<TransactionProvider>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    try {
      final response =
      await APIRequest().getRequest(route: "/transactions?type=momo");
      final decodedResponse = jsonDecode(response.body);
      transactionProvider
          .updateTransactionsData(decodedResponse['transactions']);
      print("response: ${response.body}");
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void initState() {
    super.initState();
    getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(builder: (_, data, __) {
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
              Text("Dashboard",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Colors.white)),
              NotificationIcon(context: context)
            ],
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20),
          // margin: EdgeInsets.only(bottom: 100),
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Transactions",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: isLoading
                      ? [const Text('Loading transactions...')]
                      : transactions.isEmpty
                      ? [const Text("No transaction has been added.")]
                      : transactions.map<Widget>((transaction) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        transactionCard(
                          id: transaction.id!,
                            context,
                        transaction.payload['name'] ?? '-',
                        transaction.payload['email'] ?? '',
                        transaction.payload['amount'].toString() ??
                        '', transaction.payload['currency'] ?? '', 'Success', formatDateWithSlash(transaction.date!)),
                    const SizedBox(
                    height: 30
                    ,
                    )
                    ]
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNewTransaction(),
                ),
              );
            },
            foregroundColor: Colors.white,
            backgroundColor: AppUtils.PrimaryColor,
            shape: CircleBorder(),
            child: const Icon(Icons.add),
          ),
        ),
      );
    });
  }

  Widget transactionCard(BuildContext context, String productName, String email,
      String price, String currency,
      String status, String date, {required int id}) {
    Color statusColor() {
      if (status == 'Success') {
        return AppUtils.GreenColor;
      } else {
        return AppUtils.RedColor;
      }
    }

    return GestureDetector(
      onTap: () {
        Uri url = Uri.parse("${AppUrl.baseUrl}/transactions/$id");
        launchInApp(url);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
        decoration: BoxDecoration(
            color: AppUtils.White,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 211, 211, 211),
                  blurRadius: 10,
                  spreadRadius: 0.5)
            ]),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productName,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
                          // fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text(
                        '$currency $price',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
                          fontSize: 11,
                          color: AppUtils.DarkColor.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    email,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(
                      fontSize: 13,
                      color: AppUtils.DarkColor.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    // spacing: 8,
                    // runAlignment: WrapAlignment.center,
                    children: [
                      IntrinsicWidth(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.8,
                                color: AppUtils.DarkColor.withOpacity(0.1),
                              ),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: statusColor(),
                                size: 8,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                status,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                  fontSize: 11,
                                  color:
                                  AppUtils.DarkColor.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      IntrinsicWidth(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.circle,
                                color: AppUtils.SecondaryGray,
                                size: 5,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                date,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                  fontSize: 11,
                                  color: AppUtils.DarkColor.withOpacity(0.9),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Container(
              height: 35,
              width: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppUtils.SecondaryGray.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
