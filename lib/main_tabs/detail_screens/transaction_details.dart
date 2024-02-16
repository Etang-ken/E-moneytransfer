import 'package:flutter/material.dart';
import 'package:truelife_mobile/helper/app_utils.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:truelife_mobile/main_tabs/widgets/notification_icon.dart';
import 'package:truelife_mobile/widgets/primary_button.dart';

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
                                                color: AppUtils.DarkColor
                                                    .withOpacity(0.5),
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
                                                color: AppUtils.DarkColor
                                                    .withOpacity(0.5),
                                              ),
                                        ),
                                        TextSpan(
                                          text: 'Wisdom Umanah ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppUtils.DarkColor
                                                    .withOpacity(0.8),
                                              ),
                                        ),
                                        TextSpan(
                                          text: 'was successful ',
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
                                          AppUtils.SecondaryGray.withOpacity(
                                              0.7),
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
                                            .copyWith(
                                                fontWeight: FontWeight.w500),
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
                                      transactionTitleAndDetail(
                                          'Amount', 'XAF 3000',
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
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    decoration: BoxDecoration(
                        color: AppUtils.White,
                        borderRadius: BorderRadius.circular(15)),
                    child: Table(
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppUtils.SecondaryGray.withOpacity(0.5),
                            ),
                          ),
                          children: [
                            TableCell(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 3),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: AppUtils.SecondaryGray.withOpacity(
                                          0.5),
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Items',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 3),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: AppUtils.SecondaryGray.withOpacity(
                                          0.5),
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Quantity',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 3),
                                child: Center(
                                  child: Text(
                                    'Price',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        tableValues('Paracetamol', '12', 3000),
                        tableValues('Iboprofene', '07', 5000),
                        tableValues('Damatol', '23', 40000),
                        tableValues('Azur', '05', 2500),
                        tableValues('Azul', '02', 500000),
                        tableValues('Lumerthem', '14', 50000),
                        tableValues('Panadol', '12', 24000),
                        TableRow(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppUtils.SecondaryGray.withOpacity(0.5),
                            ),
                          ),
                          children: [
                            TableCell(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 3),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: AppUtils.SecondaryGray.withOpacity(
                                          0.5),
                                    ),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Total',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 3),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: AppUtils.SecondaryGray.withOpacity(
                                          0.5),
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '75',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 3),
                                child: Center(
                                  child: Text(
                                    'XAF 624500.0',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: const BoxDecoration(
                color: AppUtils.TertiaryExtraLight,
              ),
              child: PrimaryButton(
                buttonText: 'Download',
                iconPosition: IconPosition.left,
                btnIcon: const Icon(
                  Icons.download,
                ),
                onClickBtn: () {},
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

  TableRow tableValues(String item, String quantity, double price) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppUtils.SecondaryGray.withOpacity(0.5),
        ),
      ),
      children: [
        TableCell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: AppUtils.SecondaryGray.withOpacity(0.5),
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                item,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: AppUtils.SecondaryGray.withOpacity(0.5),
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                quantity,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '$price',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
