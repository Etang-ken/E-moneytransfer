import 'package:flutter/material.dart';
import 'package:truelife_mobile/helper/app_utils.dart';
import 'package:dotted_line/dotted_line.dart';

class TransactionDetails extends StatefulWidget {
  const TransactionDetails({super.key});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  String status = 'success';
  Color statusColor() {
    if (status == 'success') {
      return AppUtils.PrimaryColor;
    } else {
      return AppUtils.RedColor;
    }
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
            Text(
              "Profile",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.white),
            ),
            Icon(
              Icons.notifications_outlined,
              color: AppUtils.White,
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                          constraints: BoxConstraints(maxWidth: 250),
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
                                          color: AppUtils.DarkColor.withOpacity(
                                              0.5),
                                        ),
                                  ),
                                  TextSpan(
                                    text: "-XAF 3000 ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: statusColor(),
                                        ),
                                  ),
                                  TextSpan(
                                    text: 'to ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppUtils.DarkColor.withOpacity(
                                              0.5),
                                        ),
                                  ),
                                  TextSpan(
                                    text: 'Wisdom Umanah ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppUtils.DarkColor.withOpacity(
                                              0.8),
                                        ),
                                  ),
                                  TextSpan(
                                    text: 'was successful ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppUtils.DarkColor.withOpacity(
                                              0.5),
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
                                  color: AppUtils.SecondaryGrayExtraLight,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15))),
                            ),
                            Expanded(
                              child: DottedLine(
                                lineThickness: 2,
                                dashLength: 5,
                                dashColor:
                                    AppUtils.SecondaryGray.withOpacity(0.7),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 15,
                              decoration: BoxDecoration(
                                  color: AppUtils.SecondaryGrayExtraLight,
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
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                transactionTitleAndDetail(
                                    'Product Name', 'Paracetamol'),
                                transactionTitleAndDetail(
                                    'Quantity', '12 cards'),
                                transactionTitleAndDetail(
                                    'Payment Date', '12-10-2023'),
                                transactionTitleAndDetail(
                                    'Transaction Number', '237623762'),
                                transactionTitleAndDetail(
                                    'Payment Type', 'MTN MoMo'),
                                // transactionTitleAndDetail('Paymnt Date', 'Paracetamol'),
                                transactionTitleAndDetail(
                                    'Payment Status',
                                    status == 'success'
                                        ? 'Successful'
                                        : 'Failed',
                                    paymentStatus: status),
                                transactionTitleAndDetail('Amount', 'XAF 3000',
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
                  // top: ,
                  left: 0,
                  right: 0,
                  child: Icon(
                    Icons.receipt_sharp,
                    color: statusColor(),
                    size: 100,
                  ),
                ),
                Positioned(
                  top: 75,
                  left: 60,
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
          ],
        ),
      ),
    );
  }

  Widget transactionTitleAndDetail(String title, String detail,
      {String? paymentStatus, bool isAmount = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
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
          Text(
            detail,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: isAmount ? 16 : 12,
                fontWeight: FontWeight.w700,
                color: paymentStatus != null
                    ? statusColor()
                    : (isAmount
                        ? AppUtils.DarkColor.withOpacity(0.7)
                        : AppUtils.SecondaryGray)),
          ),
        ],
      ),
    );
  }
}
