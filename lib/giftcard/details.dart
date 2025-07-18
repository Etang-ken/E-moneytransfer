
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/url.dart';
import '../helper/app_utils.dart';

class GiftcardDetails extends StatefulWidget {
  dynamic transaction;

  GiftcardDetails(this.transaction);

  @override
  _GiftcardDetailsState createState() => new _GiftcardDetailsState();
}

class _GiftcardDetailsState extends State<GiftcardDetails> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppUtils.SecondaryGrayExtraLight,
      appBar: AppBar(
        backgroundColor: AppUtils.PrimaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                )),
            Text("Digital Services",
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Colors.white)),
          ],
        ),
      ),
      body:  Stack(
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
                                'Transaction Initiated Successful',
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
                                          text: 'Gift card sales of ',
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
                                          "${widget.transaction['amount']} ${widget.transaction['receivable_payload']['from']??""} ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: transactionStatusColor(widget.transaction['status']),
                                          ),
                                        ),

                                        TextSpan(
                                          text: ' is '+widget.transaction['status'],
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                      transactionTitleAndDetail(
                                          "Status",
                                          widget.transaction['status'], status: true ),
                                      transactionTitleAndDetail(
                                          "Amount",
                                        "${widget.transaction['amount'].toString()}  ${widget.transaction['receivable_payload']['from']??""}"),

                                      transactionTitleAndDetail(
                                          "Type",
                                          "${widget.transaction['type'].toString()}"),


                                      transactionTitleAndDetail(
                                          "Amount Receivable",
                                          "${widget.transaction['amount_payable'].toString()}  ${widget.transaction['receivable_payload']['to']??""}"),

                                      transactionTitleAndDetail(
                                          "Payment method",
                                          "${widget.transaction['payment_method'].toString()}"),

                                      if( widget.transaction['payment_method'] == "btc")...[
                                        transactionTitleAndDetail(
                                            "Wallet ID",
                                            widget.transaction['receivable_payload']['wallet_id'] ?? "-"),
                                       ],

                                      if( widget.transaction['payment_method'] == "momo")...[
                                        transactionTitleAndDetail(
                                            "Momo Name",
                                            widget.transaction['receivable_payload']['momo_name'] ?? "-"),
                                        transactionTitleAndDetail(
                                            "Momo Number",
                                            widget.transaction['receivable_payload']['momo_number'] ?? "-"),
                                      ],

                                      Wrap(
                                          direction: Axis.horizontal,
                                          children: widget.transaction['payment_payload']['images'].map<Widget>((image) =>
                                              Image.network("${AppUrl.appUrl}/storage/"+image, height: 100)
                                          ).toList()),

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
                              color: transactionStatusColor(widget.transaction['status']), shape: BoxShape.circle),
                          child: Icon(
                            widget.transaction['status'] == 'success' ? Icons.check : Icons.close,
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
      )

    );
  }


  Widget transactionTitleAndDetail(String title, String detail,
      {String? paymentStatus, bool isAmount = false, bool status = false}) {
    print(widget.transaction);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppUtils.SecondaryGray),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
                color: status?(detail == "done"?Color(0xff00ff00):transactionStatusColor(widget.transaction['status'])):Colors.transparent
            ),
            child: Text(
              detail,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: isAmount ? 16 : 12,
                  fontWeight: FontWeight.w700,
                  color: status?Color(0xffffffff):


                  paymentStatus != null
                      ? transactionStatusColor(widget.transaction['status'])
                      : (isAmount
                      ? AppUtils.DarkColor.withOpacity(0.7)
                      : AppUtils.SecondaryGray)),
            ),
          )
        ],
      ),
    );
  }


}
