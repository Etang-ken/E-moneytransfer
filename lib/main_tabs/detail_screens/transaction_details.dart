import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truelife_mobile/api/request.dart';
import 'package:truelife_mobile/helper/app_utils.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:truelife_mobile/main_tabs/widgets/notification_icon.dart';
import 'package:truelife_mobile/provider/transaction.dart';
import 'package:truelife_mobile/widgets/primary_button.dart';

class TransactionDetails extends StatefulWidget {
  const TransactionDetails({super.key});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  bool isLoading = false;

  Future<void> completeStatus(BuildContext ctx) async {
    setState(() {
      isLoading = true;
    });
    final hasConnectivity = await hasInternetConnectivity(ctx);
    if (!hasConnectivity) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    final TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(ctx, listen: false);

    final transactionId = transactionProvider.transactionDetail.id;
    final response = await APIRequest().postRequest(
        route: '/transaction/complete', data: {"transactionId": transactionId});
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final transactions = decodedResponse['transactions'];
      transactionProvider.updateTransactionsData(transactions);
      if (transactions.isNotEmpty) {
        final dynamic transactionDetail = transactions.firstWhere(
            (transact) => transact['id'] == transactionId,
            orElse: () => null);
        if (transactionDetail != null) {
          transactionProvider
              .updateTransactionDetailUsingBrackets(transactionDetail);

          setState(() {
            isLoading = false;
          });

          AppUtils.showSnackBar(context, ContentType.success,
              'Transaction completed successfully.');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const TransactionDetails(),
            ),
          );
          return;
        }
      }
      AppUtils.showSnackBar(
          context, ContentType.success, 'Transaction completed successfully.');
    } else {
      if (!mounted) return;
      AppUtils.showSnackBar(context, ContentType.failure,
          'Error getting completing transaction.');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    if (transactionProvider.transactionDetail.id == null ||
        transactionProvider.transactionDetail.id == 0) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(builder: (_, data, __) {
      final transactionData = data.transactionDetail;
      return Stack(
        children: [
          Scaffold(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            IntrinsicHeight(
                              child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 60),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                constraints:
                                    const BoxConstraints(minHeight: 300),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      constraints:
                                          BoxConstraints(maxWidth: 250),
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
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          transactionStatusColor(
                                                              transactionData
                                                                  .status!),
                                                    ),
                                              ),
                                              TextSpan(
                                                text: 'to ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                              color: AppUtils
                                                  .SecondaryGrayExtraLight,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15))),
                                        ),
                                        Expanded(
                                          child: DottedLine(
                                            lineThickness: 2,
                                            dashLength: 5,
                                            dashColor: AppUtils.SecondaryGray
                                                .withOpacity(0.7),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 15,
                                          decoration: BoxDecoration(
                                              color: AppUtils
                                                  .SecondaryGrayExtraLight,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15),
                                                      bottomLeft:
                                                          Radius.circular(15))),
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
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            transactionTitleAndDetail(
                                                'Type',
                                                textCapitalize(
                                                    transactionData.type ??
                                                        '')),
                                            transactionTitleAndDetail(
                                                'Quantity',
                                                transactionData.items!.length
                                                    .toString()),
                                            transactionTitleAndDetail(
                                                'Date',
                                                formatDateWithHyphen(
                                                    transactionData.createdAt ??
                                                        '')),
                                            transactionTitleAndDetail(
                                                'Status',
                                                textCapitalize(
                                                    transactionData.status ??
                                                        ''),
                                                paymentStatus:
                                                    transactionData.status),
                                            transactionTitleAndDetail('Amount',
                                                "XAF ${calculateTotalItemPrice(transactionData.items!).toString()}",
                                                isAmount: true),
                                            if (transactionData.status ==
                                                'delivered')
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: IntrinsicWidth(
                                                    child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 25),
                                                  child: PrimaryButton(
                                                    buttonText:
                                                        'Complete Transaction',
                                                    onClickBtn: () {
                                                      completeStatus(context);
                                                    },
                                                  ),
                                                )),
                                              ),
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
                                color: transactionStatusColor(
                                    transactionData.status!),
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
                                    color: transactionStatusColor(
                                        transactionData.status!),
                                    shape: BoxShape.circle),
                                child: Icon(
                                  transactionData.status! == 'Success'
                                      ? Icons.check
                                      : transactionData.status! == 'Failed'
                                          ? Icons.close
                                          : Icons.info_outline,
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
                                    color:
                                        AppUtils.SecondaryGray.withOpacity(0.5),
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
                                            color: AppUtils.SecondaryGray
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Items',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
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
                                            color: AppUtils.SecondaryGray
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Quantity',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (transactionData.items != null &&
                                  transactionData.items!.isNotEmpty)
                                ...transactionData.items!.map<TableRow>((item) {
                                  return tableValues(
                                      item['product']!['name'],
                                      item['quantity'].toString(),
                                      calculateSingleItemPrice(item));
                                }).toList(),
                              if (transactionData.items == null ||
                                  transactionData.items!.isEmpty)
                                TableRow(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppUtils.SecondaryGray.withOpacity(
                                          0.5),
                                    ),
                                  ),
                                  children: [
                                    TableCell(
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 3),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                              color: AppUtils.SecondaryGray
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'No item',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              TableRow(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        AppUtils.SecondaryGray.withOpacity(0.5),
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
                                            color: AppUtils.SecondaryGray
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Total',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
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
                                            color: AppUtils.SecondaryGray
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          calculateTotalItemQuantity(
                                                  transactionData.items ?? [])
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
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
                                          'XAF ${calculateTotalItemPrice(transactionData.items ?? [])}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
          ),
          if (isLoading) showIsLoading()
        ],
      );
    });
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
                    ? transactionStatusColor(paymentStatus)
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
