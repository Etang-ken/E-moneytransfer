import 'package:flutter/material.dart';
import 'package:truelife_mobile/helper/app_utils.dart';
import 'package:truelife_mobile/main_tabs/detail_screens/transaction_details.dart';
import 'package:truelife_mobile/main_tabs/widgets/notification_icon.dart';
import 'package:truelife_mobile/main_tabs/widgets/transaction.dart';

class ClientTransactions extends StatefulWidget {
  const ClientTransactions({super.key});

  @override
  State<ClientTransactions> createState() => _ClientTransactionsState();
}

class _ClientTransactionsState extends State<ClientTransactions> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppUtils.SecondaryGrayExtraLight,
      appBar: AppBar(
        backgroundColor: AppUtils.PrimaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.chevron_left,
                    color: AppUtils.White,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  "Client Transactions",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
            NotificationIcon(context: context)
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        // margin: const EdgeInsets.only(bottom: ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TransactionDetails(),
                    ),
                  );
                },
                child: transactionCard(
                    context, 'Paracetamol', '3000', 'Success', '12/02/2024'),
              ),
              transactionCard(
                  context, 'Cotrim', '5000', 'Failed', '12/02/2024'),
              transactionCard(
                  context, 'Mabendazole', '10000', 'Success', '12/02/2024'),
              transactionCard(
                  context, 'Cold Cap', '6000', 'Success', '12/02/2024'),
              transactionCard(
                  context, 'Paracetamol', '3000', 'Failed', '12/02/2024'),
              transactionCard(
                  context, 'Cold Cap', '6000', 'Success', '12/02/2024'),
              transactionCard(
                  context, 'Paracetamol', '3000', 'Failed', '12/02/2024'),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
