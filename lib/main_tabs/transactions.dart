import 'package:flutter/material.dart';
import 'package:truelife_mobile/helper/app_utils.dart';
import 'package:truelife_mobile/main_tabs/widgets/notification_icon.dart';
import 'package:truelife_mobile/main_tabs/widgets/transaction.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
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
              transactionCard(context, 'Paracetamol', '3000', 'Success',
                  '12 cards', '12/02/2024'),
              transactionCard(context, 'Cotrim', '5000', 'Failed', '10 cards',
                  '12/02/2024'),
              transactionCard(context, 'Mabendazole', '10000', 'Success',
                  '20 cards', '12/02/2024'),
              transactionCard(context, 'Cold Cap', '6000', 'Success',
                  '50 cards', '12/02/2024'),
              transactionCard(context, 'Paracetamol', '3000', 'Failed',
                  '12 cards', '12/02/2024'),
              transactionCard(context, 'Cold Cap', '6000', 'Success',
                  '50 cards', '12/02/2024'),
              transactionCard(context, 'Paracetamol', '3000', 'Failed',
                  '12 cards', '12/02/2024'),
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
