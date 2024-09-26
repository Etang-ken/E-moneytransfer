import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:provider/provider.dart';

import '../../helper/app_utils.dart';
import '../widgets/notification_icon.dart';

class TransactionDetails extends StatefulWidget {
  dynamic transaction;

  TransactionDetails(this.transaction);

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState(transaction);
}

class _TransactionDetailsState extends State<TransactionDetails> {

  dynamic transaction;


  _TransactionDetailsState(this.transaction);

  String status = 'success';

  Color statusColor() {
    if (status == 'success') {
      return AppUtils.PrimaryColor;
    } else {
      return AppUtils.RedColor;
    }
  }

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
                      .headline4
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
            NotificationIcon(context: context)
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
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
                                'Transaction Successful',
                                style: Theme.of(context).textTheme.headline5!,
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
                                              .bodyText1!
                                              .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppUtils.DarkColor
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                          "${transaction.payload['amount_received']} BTC ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: statusColor(),
                                          ),
                                        ),

                                        TextSpan(
                                          text: ' is '+transaction.status,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
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
                                            .headline6!
                                            .copyWith(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      transactionTitleAndDetail(
                                          "Status",
                                          transaction.status ),
                                      transactionTitleAndDetail(
                                          "Wallet ID",
                                          transaction.payload['wallet_id'] ??
                                              "-"),

                                      transactionTitleAndDetail(
                                          'Transaction Date',
                                          "Today"),
                                      // transactionTitleAndDetail('Paymnt Date', 'Paracetamol'),
                                      transactionTitleAndDetail('Amount',
                                          "${transaction.payload['to']} ${transaction.payload['amount_received']}",
                                          isAmount: true),
                                    ],
                                  ),
                                ),
                              ),

                              // Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: Container(
                              //     padding: const EdgeInsets.symmetric(
                              //       vertical: 10,
                              //       horizontal: 20,
                              //     ),
                              //     child: Column(
                              //       children: [
                              //         Text(
                              //           'Conversion Details',
                              //           textAlign: TextAlign.left,
                              //           style: Theme.of(context)
                              //               .textTheme
                              //               .headline6!
                              //               .copyWith(
                              //               fontWeight: FontWeight.w500),
                              //         ),
                              //         const SizedBox(
                              //           height: 15,
                              //         ),
                              //
                              //         transactionTitleAndDetail(
                              //             "Rate",
                              //             "1 ${transaction.payload['from']} -> ${transaction.payload['rate']} ${transaction.payload['to']}"),
                              //
                              //         transactionTitleAndDetail(
                              //             "Converted",
                              //             "${transaction.payload['from']} ${transaction.payload['amount_send']}  -> ${transaction.payload['to']} ${double.parse(transaction.payload['rate']) * double.parse(transaction.payload['amount_send'])}"),
                              //
                              //
                              //         transactionTitleAndDetail(
                              //             "Commission",
                              //             "${transaction.payload['commission']}%  (${double.parse(transaction.payload['rate']) * double.parse(transaction.payload['amount_send']) - (1- double.parse(transaction.payload['commission'])/100) * double.parse(transaction.payload['commission']) * double.parse(transaction.payload['amount_send']) } )"),
                              //
                              //
                              //         transactionTitleAndDetail('Net Amount Receivable',
                              //             "XAF ${transaction.payload['amount_received']}",
                              //             isAmount: true),
                              //       ],
                              //     ),
                              //   ),
                              // ),
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
                              color: statusColor(), shape: BoxShape.circle),
                          child: Icon(
                            status == 'success' ? Icons.check : Icons.close,
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
        ],
      ),
    );
  }

  Widget transactionTitleAndDetail(String title, String detail,
      {String? paymentStatus, bool isAmount = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppUtils.SecondaryGray),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(child: Text(
            detail,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: isAmount ? 16 : 12,
                fontWeight: FontWeight.w700,
                color: paymentStatus != null
                    ? statusColor()
                    : (isAmount
                    ? AppUtils.DarkColor.withOpacity(0.7)
                    : AppUtils.SecondaryGray)),
            maxLines: 2,
          )),
        ],
      ),
    );
  }
}
