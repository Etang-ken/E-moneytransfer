import 'package:flutter/material.dart';
import 'package:eltransfer/helper/app_utils.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:eltransfer/screens/widgets/notification_icon.dart';

class TransactionDetails extends StatefulWidget {
  dynamic transaction;

  TransactionDetails(this.transaction);

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState(transaction);
}

class _TransactionDetailsState extends State<TransactionDetails> {

  dynamic transaction;


  _TransactionDetailsState(this.transaction);

  void initState() {
    super.initState();
  }

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
                  "Transaction",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
            NotificationIcon(context: context)
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  IntrinsicHeight(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 60),
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      constraints: const BoxConstraints(minHeight: 300),
                      decoration: BoxDecoration(
                        color: AppUtils.White,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            'Transaction created successfully',
                            style: Theme.of(context).textTheme.headlineMedium!,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Container(
                            constraints:
                            const BoxConstraints(minWidth: 250),
                            child: Center(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Transfer of ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppUtils.DarkColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                      "XAF ${transaction.payload['amount_received']} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: statusColor(transaction.status),
                                      ),
                                    ),

                                    TextSpan(
                                      text: 'to ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppUtils.DarkColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    TextSpan(
                                      text:  transaction.payload['receiver_phone'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppUtils.DarkColor
                                            .withOpacity(0.8),
                                      ),
                                    ),

                                    TextSpan(
                                      text: ' is '+transaction.status,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppUtils.DarkColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 15,
                                decoration: BoxDecoration(
                                    color:
                                    AppUtils.SecondaryGrayExtraLight,
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomRight:
                                        Radius.circular(15))),
                              ),
                              Expanded(
                                child: DottedLine(
                                  lineThickness: 2,
                                  dashLength: 5,
                                  dashColor:
                                  AppUtils.SecondaryGray.withOpacity(
                                      0.7),
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 15,
                                decoration: BoxDecoration(
                                    color:
                                    AppUtils.SecondaryGrayExtraLight,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15))),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Transaction Details',
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  transactionTitleAndDetail(context,
                                      "Status", transaction.status, status: true),
                                  transactionTitleAndDetail(context,
                                      transaction.payload["method"] != "bank"?"Receiver's Name":"Account Name",
                                      transaction.payload['receiver_name'] ??
                                          "-"),
                                  transactionTitleAndDetail(context,
                                      transaction.payload["method"] != "bank"?"Receiver's Phone":"Account Number",
                                      transaction.payload['receiver_phone'] ??
                                          "-"),
                                  if(transaction.payload["method"]!= "momo")...[
                                    transactionTitleAndDetail(context,
                                        "Bank Name",
                                        transaction.payload["bank"] ??
                                            "-")
                                  ],

                                  transactionTitleAndDetail(context,
                                      'Transaction Date',
                                      transaction.date ??
                                          "-"),
                                  transactionTitleAndDetail(context,"Amount to Send", "${transaction.payload['from']} ${transaction.payload['amount_send']}"),
                                  transactionTitleAndDetail(
                                      context,'Amount Receivable',
                                      "XAF ${transaction.payload['amount_received']}",
                                      isAmount: true),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 75,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: statusColor(transaction.status), shape: BoxShape.circle),
                      child: Icon(
                        ["completed","done"].contains(transaction.status) ? Icons.check : ["draft","pending","processing"].contains(transaction.status) ? Icons.refresh :Icons.close,
                        color: AppUtils.White,
                        // size: 40,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
