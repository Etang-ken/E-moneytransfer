import 'package:elcrypto/screens/widgets/notification_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/app_utils.dart';
import '../provider/transaction.dart';
import 'detail_screens/add_new_transaction.dart';
import 'detail_screens/transaction_detail.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

enum BorderLeftOrRight { left, right }

class _DashboardState extends State<Dashboard> {
  late TransactionProvider transactionProvider;

  Future<void> getTransactions() async {
    transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);

    transactionProvider.getTransactions();
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
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: Colors.white)),
              NotificationIcon(context: context)
            ],
          ),
        ),
        body:Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20),
            // margin: EdgeInsets.only(bottom: 100),
            height: MediaQuery.of(context).size.height,
            child: RefreshIndicator(
                onRefresh: () async {
                  transactionProvider.getTransactions();
                },
                child:
                transactionProvider.lockApp ?
                Container(padding: EdgeInsets.symmetric(horizontal: 30), child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.warning),
                      const SizedBox(width: 10.0),
                      Text(
                        "An update is available!",
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => launchUrl(
                          "https://play.google.com/store/apps/details?id=com.elcrypto.app" as Uri,
                        ), // Launch Pla y Store
                        child: Text(
                          "Update Now",
                          style: TextStyle(color:AppUtils.PrimaryColor),
                        ),
                      ),
                    ],
                  ),
                ),) :
                ListView(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(child: Text(
                      "Transactions",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: transactionProvider.isLoading
                          ? [const Text('Loading transactions...')]
                          : transactions.isEmpty
                          ? [const Text("No transaction has been added.")]
                          : transactions.map<Widget>((transaction) {
                        return Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              transactionCard(context,
                                  transaction: transaction),
                              const SizedBox(
                                height: 10,
                              )
                            ]);
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ))),
        floatingActionButton: transactionProvider.lockApp?Container():Padding(
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

  Widget transactionCard(BuildContext context, {required dynamic transaction}) {
    Color statusColor() {
      if (transaction.status == 'Success') {
        return AppUtils.GreenColor;
      } else {
        return AppUtils.RedColor;
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransactionDetails(transaction)));
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 15),
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
                        transaction.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          // fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
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
                                transaction.status,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
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
                                transaction.date,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
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
