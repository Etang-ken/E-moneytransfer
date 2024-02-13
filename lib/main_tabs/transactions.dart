import 'package:flutter/material.dart';
import 'package:truelife_mobile/helper/app_utils.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppUtils.PrimaryColor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Transactions",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Colors.white)),
              Icon(
                Icons.notifications_outlined,
                color: AppUtils.White,
              )
            ],
          ),
        ),
        body: Container()
    );
  }
}